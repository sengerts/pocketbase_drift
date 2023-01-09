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

  Stream<double> _fetchRemoteList(
    String collection, {
    int perPage = _kDefaultPageSize,
    String? filter,
    String? sort,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
    PocketBaseErrorHandler? onError,
  }) {
    final streamController = StreamController<double>();

    streamController.add(0.0);

    final result = <ExtendedRecordModel>[];

    Future<void> request(int page, StreamController<double> streamController) async {
      // if this fails (e.g. due to loss of internet connection), the outer transaction will be rollbacked
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
        streamController.add(progress);
      }

      // Add to database
      await database.setRecords(extendedListItems);

      if (list.items.isNotEmpty && list.totalItems > result.length) {
        await request(page + 1, streamController);
      }

      // TODO Store (collection,filter) last full sync entry
    }

    database.transaction(() async {
      await request(1, streamController);
      streamController.add(1.0);
    }).catchError((e) {
      // in case of any error during fetching, the whole transaction is rollbacked -> same local data as before trying to fetch from remote
      debugPrint('error fetching records for $collection: $e');
      // TODO Mark collection locally as dirty/ old
      onError?.call(e);
    }).whenComplete(() => streamController.close());

    return streamController.stream;
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
        await _fetchRemoteList(collection, onError: onError).last;
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
        rethrow; // should not get here as above getRecord already rethrows if neither remote nor local record available
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

    /* TODO Lock remote database collection so C,U,D operations on data during syncing will be denied (pessimistic locking)
        -> this should prevent inconsistencies causes by simultaneous syncing of user A and operation of user B
     */

    ///
    /// PUSH LOCAL (OFFLINE) CHANGES TO ONLINE COLLECTION
    ///

    /* TODO Find all marked unsynced created local items in collection and for each:
        if no corresponding unsynced delete for same item: always add since equivalency check hard/ not useful in general
     */

    /* TODO Find all marked unsynced updated local items in collection and for each:
        if no corresponding unsynced delete for same item:
          1. find corresponding online record, if it exists and updatedAt > lastSyncUpdated of local record, call
          merge conflict resolution callback (let user decide which version to keep) and then act accordingly
          2. else: overwrite online record with local record, for deletion. delete online record as well
     */

    /* TODO Find all marked unsynced local items in collection and for each:
        if there is a corresponding unsynced creation for same item (item locally created and deleted without ever being available remotely):
          do thing
        else: delete record online
     */

    ///
    /// PULL NEW DATA FROM ONLINE COLLECTION
    ///

    /* TODO Check what _fetchList -> setRecords does exactly: it seems that it only adds the new entries and old (lo longer existing) entries stay
        especially we do not detect deleted remote entries this way, so I think we should just load the whole collection from remote and replace the
        local collection with it to enable consistency between local and remote collection
     */

    // TODO Determine lastSynced = max(last full sync whole collection, last full sync collection with given filter)
    // TODO Only retrieve remote entries with updated > lastSynced
    final local = await database.getRecords(collection);
    final lastRecord = local.newest(); // TODO exclude dirty records such that we retrieve the newest record in sync with online collection

    yield* _fetchRemoteList(
      collection,
      filter: lastRecord == null
          ? filter
          : [
              "updated > '${lastRecord.updated /* TODO Replace with lastSynced */}'",
              if (filter != null) filter,
            ].join(' && '),
      onError: onError,
    );

    /* TODO To handle remote deletions not reflected locally yet, retrieve (filtered) collection size remotely and compare with
        local size of same (filtered) collection:

        If remote_size = local_size: everything in sync now
        if remote_size < local_size: remote deletions not reflected locally -> identify these and delete locally as well
        if remote_size > local_size: either we have a bug in our sync logic or the user's app lost
          internet connection/ crashed during an unfortunate time (e.g. during sync)
          or during sync a remote item was added -> full resync needed
     */

    yield 1.0;

    // TODO Unlock remote database collection again
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
    return ExtendedRecordModel(
      id: recordModel.id,
      created: recordModel.created,
      updated: recordModel.updated,
      collectionId: recordModel.collectionId,
      collectionName: recordModel.collectionName,
      data: recordModel.data,
      unsyncedRead: false,
      unsyncedCreation: false,
      unsyncedUpdate: false,
      lastSyncUpdated: recordModel.updated,
    );
  }

  static ExtendedRecordModel buildUnsyncedCreatedRecordModelFrom(final String collectionIdOrName, final Map<String, dynamic> data) {
    return ExtendedRecordModel(
      collectionId: collectionIdOrName,
      collectionName: collectionIdOrName,
      data: data,
      unsyncedCreation: true,
    );
  }

  static ExtendedRecordModel buildUnsyncedUpdateRecordModelFrom(final ExtendedRecordModel recordModel, final Map<String, dynamic> data) {
    return ExtendedRecordModel(
      id: recordModel.id,
      created: recordModel.created,
      updated: recordModel.updated,
      collectionId: recordModel.collectionId,
      collectionName: recordModel.collectionName,
      data: data,
      unsyncedRead: recordModel.unsyncedRead,
      unsyncedCreation: recordModel.unsyncedCreation,
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
