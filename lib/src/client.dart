part of '../pocketbase_drift.dart';

const int _kDefaultPageSize = 250;

typedef PocketBaseErrorHandler = void Function(Object e);

/// [PocketBase] client backed by drift store (sqlite)
class PocketBaseDrift {
  PocketBaseDrift(
    this.url, {
    this.connection,
    this.dbName = 'database.db',
  })  : pocketbase = createPocketBaseClient(url),
        database = PocketBaseDatabase(dbName: dbName, connection: connection);

  /// [Url] of [PocketBase] server
  final String url;

  final DatabaseConnection? connection;
  final String dbName;

  /// [PocketBase] internal client
  final PocketBase pocketbase;

  /// [PocketBase] internal database
  final PocketBaseDatabase database;

  Stream<double> _fetchList(
    String collection, {
    int perPage = _kDefaultPageSize,
    String? filter,
    String? sort,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
    PocketBaseErrorHandler? onError,
  }) async* {
    yield 0.0;
    final result = <ExtendedRecordModel>[];

    Stream<double> request(int page) async* {
      try {
        final list = await pocketbase.collection(collection).getList(
              page: page,
              perPage: perPage,
              filter: filter,
              sort: sort,
              query: query,
              headers: headers,
            );

        final extendedListItems = list.items.map(buildFreshExtendedRecordModelFrom).toList();

        debugPrint('fetched ${list.items.length} records for $collection');
        result.addAll(extendedListItems);

        final progress = list.page / list.totalPages;
        if (!progress.isInfinite) {
          yield progress;
        }

        // Add to database
        await database.setRecords(extendedListItems);

        if (list.items.isNotEmpty && list.totalItems > result.length) {
          yield* request(page + 1);
        }
      } catch (e) {
        debugPrint('error fetching records for $collection: $e');
        // TODO Mark collection locally as dirty/ old
        onError?.call(e);
      }
    }

    yield* request(1);

    yield 1.0;
  }

  Future<ExtendedRecordModel?> getRecord(
    String collection,
    String id, {
    FetchPolicy policy = FetchPolicy.localAndRemote,
    PocketBaseErrorHandler? onError,
  }) async {
    if (policy == FetchPolicy.remoteOnly) {
      try {
        return buildFreshExtendedRecordModelFrom(await pocketbase.collection(collection).getOne(id));
      } catch (e) {
        debugPrint('error getting remote record $collection/$id --> $e');
        // no data can be retrieved so we must rethrow the error
        rethrow;
      }
    } else if (policy == FetchPolicy.localOnly) {
      return database.getRecord(collection, id);
    }
    final local = await database.getRecord(collection, id);
    try {
      final remote = buildFreshExtendedRecordModelFrom(await pocketbase.collection(collection).getOne(id));
      // ignore: unnecessary_null_comparison
      if (remote != null) {
        await database.setRecord(buildFreshExtendedRecordModelFrom(remote));
      }
      return remote;
    } catch (e) {
      debugPrint('error getting remote record $collection/$id --> $e');
      if (local != null) {
        // Mark record with given id in given collection locally as dirty/ old
        local.unsyncedRead = true;
        await database.setRecord(local);

        // no rethrow necessary as we at least have the local record but call onError handler
        // TODO Instead of calling onError handler, rather call onMarkUnsynced handler?
        onError?.call(e);
      } else {
        // neither local nor remote data available
        rethrow;
      }
    }
    return local;
  }

  Future<List<ExtendedRecordModel>> getRecords(
    String collection, {
    FetchPolicy policy = FetchPolicy.localAndRemote,
    String? filter,
    PocketBaseErrorHandler? onError,
  }) async {
    if (policy == FetchPolicy.remoteOnly) {
      try {
        await _fetchList(collection, onError: onError).last;
      } catch (e) {
        debugPrint('error getting remote records for $collection --> $e');
        // no data can be retrieved so we must rethrow the error
        rethrow;
      }
    } else if (policy == FetchPolicy.localAndRemote) {
      await updateCollection(collection, filter: filter, onError: onError).last;
    }
    final results = await database.getRecords(collection);
    debugPrint('$policy --> $collection --> ${results.length}');
    return results;
  }

  Future<void> deleteRecord(
    String collection,
    String id, {
    PocketBaseErrorHandler? onError,
  }) async {
    try {
      await pocketbase.collection(collection).delete(id);
    } catch (e) {
      debugPrint('error deleting remote record $collection/$id --> $e');

      // mark item as unsynced delete
      await database.markUnsyncedDeletedRecord(collection, id, onError);

      onError?.call(e);
      // TODO Instead of calling onError handler, rather call onMarkUnsynced handler?
    }
    await database.deleteRecord(collection, id);
  }

  Future<ExtendedRecordModel> addRecord(
    String collection,
    Map<String, dynamic> data, {
    bool removeId = false,
    PocketBaseErrorHandler? onError,
  }) async {
    if (removeId) {
      data.remove('id');
    }
    late ExtendedRecordModel item;
    try {
      item = buildFreshExtendedRecordModelFrom(await pocketbase.collection(collection).create(body: data));
      await database.setRecord(item);
    } catch (e) {
      debugPrint('error additing remote record --> $e');

      // Create local item and mark it as unsynced creation
      item = buildUnsyncedCreatedRecordModelFrom(collection, data);
      await database.setRecord(item);

      // no rethrow necessary as we at least have the local record but call onError handler
      onError?.call(e);
      // TODO Instead of calling onError handler, rather call onMarkUnsynced handler?
    }
    return item;
  }

  Future<ExtendedRecordModel> updateRecord(
    String collection,
    String id,
    Map<String, dynamic> data,
    PocketBaseErrorHandler? onError,
  ) async {
    ExtendedRecordModel? item;
    try {
      item = buildFreshExtendedRecordModelFrom(await pocketbase.collection(collection).update(id, body: data));
      await database.setRecord(item);
    } catch (e) {
      debugPrint('error updating remote record with id $id --> $e');

      item = await getRecord(collection, id);
      if (item == null) {
        debugPrint('no local record found with id $id --> $e');
        // neither remote nor local item available, so rethrow
        rethrow;
      }

      // Update local item and mark it as unsynced update
      item = buildUnsyncedUpdateRecordModelFrom(item, data);
      await database.setRecord(item);

      // no rethrow necessary as we at least have the local record but call onError handler
      onError?.call(e);
      // TODO Instead of calling onError handler, rather call onMarkUnsynced handler?
    }
    return item;
  }

  Stream<List<ExtendedRecordModel>> watchRecords(
    String collection, {
    FetchPolicy policy = FetchPolicy.localAndRemote,
    String? filter,
    PocketBaseErrorHandler? onError,
  }) async* {
    yield await getRecords(
      collection,
      policy: FetchPolicy.localOnly,
      filter: filter,
      // local fetching only so no onError handling needed here
    );
    if (policy == FetchPolicy.localAndRemote) {
      await updateCollection(collection, filter: filter, onError: onError).last;
    }
    yield* database.watchRecords(collection);
  }

  Stream<ExtendedRecordModel?> watchRecord(
    String collection,
    String id,
  ) async* {
    yield* database.watchRecord(collection, id);
  }

  /// Synchronize offline and online data collection
  Stream<double> updateCollection(
    String collection, {
    String? filter,
    PocketBaseErrorHandler? onError,
  }) async* {
    // TODO If user has no internet connection, call onerror handler

    yield 0.0;

    // TODO Wrap with try catch and call onError handler on failure

    ///
    /// PUSH LOCAL (OFFLINE) CHANGES TO ONLINE COLLECTION
    ///

    /* TODO Find all marked unsynced local items in collection and for each:
        if unsynced creation: always add since equivalency check hard/ not useful in general
        if unsynced update or unsynced delete:
          1. find corresponding online record, if it exists and updatedAt > lastSyncUpdated of local record, call
          merge conflict resolution callback (let user decide which version to keep) and then act accordingly
          2. else for update: overwrite online record with local record, for deletion. delete online record as well
     */

    ///
    /// PULL NEW DATA FROM ONLINE COLLECTION
    ///

    /* TODO Check what _fetchList -> setRecords does exactly: it seems that it only adds the new entries and old (lo longer existing) entries stay
        especially we do not detect deleted remote entries this way, so I think we should just load the whole collection from remote and replace the
        local collection with it to enable consistency between local and remote collection
     */

    final local = await database.getRecords(collection);
    final lastRecord = local.newest(); // TODO exclude dirty records such that we retrieve the newest record in sync with online collection

    yield* _fetchList(
      collection,
      filter: lastRecord == null
          ? filter
          : [
              "updated > '${lastRecord.updated}'", // TODO Can we still do this with the goal states above?
              if (filter != null) filter,
            ].join(' && '),
      onError: onError,
    );

    yield 1.0;
  }

  Future<List<ExtendedRecordModel>> search(
    String query, {
    String? collection,
  }) {
    if (collection != null) {
      return database.searchCollection(query, collection);
    } else {
      return database.searchAll(query);
    }
  }

  static ExtendedRecordModel buildFreshExtendedRecordModelFrom(final RecordModel recordModel) {
    // TODO Fix: type '_InternalImmutableLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, List<RecordModel>>'
    return ExtendedRecordModel(
      id: recordModel.id,
      created: recordModel.created,
      updated: recordModel.updated,
      collectionId: recordModel.collectionId,
      collectionName: recordModel.collectionName,
      data: recordModel.data,
      unsyncedCreation: false,
      unsyncedUpdate: false,
      lastSyncUpdated: recordModel.updated,
    );
  }

  static ExtendedRecordModel buildUnsyncedCreatedRecordModelFrom(final String collectionIdOrName, final Map<String, dynamic> data) {
    // TODO Fix: type '_InternalImmutableLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, List<RecordModel>>'
    return ExtendedRecordModel(
      collectionId: collectionIdOrName,
      collectionName: collectionIdOrName,
      data: data,
      unsyncedCreation: true,
    );
  }

  static ExtendedRecordModel buildUnsyncedUpdateRecordModelFrom(final ExtendedRecordModel recordModel, final Map<String, dynamic> data) {
    // TODO Fix: type '_InternalImmutableLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, List<RecordModel>>'
    return ExtendedRecordModel(
      id: recordModel.id,
      created: recordModel.created,
      updated: recordModel.updated,
      collectionId: recordModel.collectionId,
      collectionName: recordModel.collectionName,
      data: data,
      unsyncedCreation: false,
      unsyncedUpdate: true,
      lastSyncUpdated: recordModel.lastSyncUpdated,
    );
  }
}

extension on List<ExtendedRecordModel> {
  ExtendedRecordModel? newest() {
    if (isEmpty) return null;
    return reduce((value, element) {
      final a = DateTime.parse(element.updated);
      final b = DateTime.parse(value.updated);
      return a.isAfter(b) ? element : value;
    });
  }
}

enum FetchPolicy {
  /// Cache only
  localOnly,

  /// Server only
  remoteOnly,

  /// Cache and server
  localAndRemote,
}
