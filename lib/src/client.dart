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
    final result = <RecordModel>[];

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
        debugPrint('fetched ${list.items.length} records for $collection');
        result.addAll(list.items);

        final progress = list.page / list.totalPages;
        if (!progress.isInfinite) {
          yield progress;
        }

        // Add to database
        await database.setRecords(list.items);

        if (list.items.isNotEmpty && list.totalItems > result.length) {
          yield* request(page + 1);
        }
      } catch (e) {
        debugPrint('error fetching records for $collection: $e');
        onError?.call(e);
      }
    }

    yield* request(1);

    yield 1.0;
  }

  Future<RecordModel?> getRecord(
    String collection,
    String id, {
    FetchPolicy policy = FetchPolicy.localAndRemote,
    PocketBaseErrorHandler? onError,
  }) async {
    if (policy == FetchPolicy.remoteOnly) {
      return pocketbase.collection(collection).getOne(id);
    } else if (policy == FetchPolicy.localOnly) {
      return database.getRecord(collection, id);
    }
    final local = await database.getRecord(collection, id);
    try {
      final remote = await pocketbase.collection(collection).getOne(id);
      // ignore: unnecessary_null_comparison
      if (remote != null) {
        await database.setRecord(remote);
      }
      return remote;
    } catch (e) {
      debugPrint('error getting remote record $collection/$id --> $e');
      onError?.call(e);
    }
    return local;
  }

  Future<List<RecordModel>> getRecords(
    String collection, {
    FetchPolicy policy = FetchPolicy.localAndRemote,
    String? filter,
    PocketBaseErrorHandler? onError,
  }) async {
    if (policy == FetchPolicy.remoteOnly) {
      await _fetchList(collection, onError: onError).last;
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
      onError?.call(e);
    }
    await database.deleteRecord(collection, id);
  }

  Future<RecordModel> addRecord(
    String collection,
    Map<String, dynamic> data, {
    bool removeId = false,
  }) async {
    if (removeId) {
      data.remove('id');
    }
    try {
      final item = await pocketbase.collection(collection).create(body: data);
      await database.setRecord(item);
      return item;
    } catch (e) {
      debugPrint('error additing remote record --> $e');
      // TODO Should we still add the new item to the local database in case of error?
      rethrow;
    }
  }

  Future<RecordModel> updateRecord(
    String collection,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final item = await pocketbase.collection(collection).update(id, body: data);
      await database.setRecord(item);
      return item;
    } catch (e) {
      debugPrint('error updating remote record with id $id --> $e');
      // TODO Should we still update the  item in the local database in case of error?
      rethrow;
    }
  }

  Stream<List<RecordModel>> watchRecords(
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

  Stream<RecordModel?> watchRecord(
    String collection,
    String id,
  ) async* {
    yield* database.watchRecord(collection, id);
  }

  /// Update collection from remote server and return progress
  Stream<double> updateCollection(
    String collection, {
    String? filter,
    PocketBaseErrorHandler? onError,
  }) async* {
    yield 0.0;
    final local = await database.getRecords(collection);
    final lastRecord = local.newest();

    if (lastRecord != null) {
      yield* _fetchList(
        collection,
        filter: [
          "updated > '${lastRecord.updated}'",
          if (filter != null) filter,
        ].join(' && '),
        onError: onError,
      );
    } else {
      // Missing last record, get all
      yield* _fetchList(
        collection,
        filter: filter,
        onError: onError,
      );
    }

    yield 1.0;
  }

  Future<List<RecordModel>> search(
    String query, {
    String? collection,
  }) {
    if (collection != null) {
      return database.searchCollection(query, collection);
    } else {
      return database.searchAll(query);
    }
  }
}

extension on List<RecordModel> {
  RecordModel? newest() {
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
