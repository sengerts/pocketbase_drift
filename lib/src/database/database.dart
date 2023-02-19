import 'package:drift/drift.dart';
import 'package:pocketbase_drift/pocketbase_drift.dart';

import 'connection/connection.dart' as impl;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Records, UnsyncedDeletedRecords, LastFullCollectionSyncs], include: {'sql.drift'})
class PocketBaseDatabase extends _$PocketBaseDatabase {
  PocketBaseDatabase({
    String dbName = 'database.db',
    DatabaseConnection? connection,
    bool useWebWorker = false,
    bool logStatements = false,
  }) : super.connect(
          connection ??
              impl.connect(
                dbName,
                useWebWorker: useWebWorker,
                logStatements: logStatements,
              ),
        );

  @override
  int get schemaVersion => 1;

  Future<LastFullCollectionSync?> getLastFullSyncTimestamp(String collection, String? filter) async {
    final query = select(lastFullCollectionSyncs)
      ..where((t) => t.collectionName.equals(collection))
      ..where((t) => filter == null ? t.filter.isNull() : t.filter.equals(filter))
      ..orderBy([(t) => OrderingTerm.desc(lastFullCollectionSyncs.syncTimestamp)])
      ..limit(1);
    final item = await query.getSingleOrNull();
    return item;
  }

  Future<int> setLastFullSyncTimestamp(String collection, String? filter) async {
    final entry = LastFullCollectionSyncsCompanion.insert(collectionId: collection, collectionName: collection, syncTimestamp: DateTime.now());
    final id = await into(lastFullCollectionSyncs).insert(entry);
    return id;
  }

  Future<int> setRecord(ExtendedRecordModel item) async {
    final id = await into(records).insert(
      item.toCompanion(),
      mode: InsertMode.insertOrReplace,
    );
    return id;
  }

  Future<void> setRecords(List<ExtendedRecordModel> items) {
    return transaction(
      () => batch((batch) {
        final values = items.map((item) => item.toCompanion()).toList();
        batch.insertAll(records, values, mode: InsertMode.insertOrReplace);
      }),
    );
  }

  Future<ExtendedRecordModel?> getRecord(String collection, String id) async {
    final item = await getRawRecord(collection, id);
    if (item != null) return item.toModel();
    return null;
  }

  Future<Record?> getRawRecord(String collection, String id) async {
    final query = select(records)
      ..where((t) => t.rowId.equals(id))
      ..where((t) => t.collectionName.equals(collection));
    final item = await query.getSingleOrNull();
    return item;
  }

  Future<ExtendedRecordModel?> get(int id) async {
    final query = select(records)..where((t) => t.id.equals(id));
    final item = await query.getSingleOrNull();
    return item?.toModel();
  }

  Future<int> set(ExtendedRecordModel item) {
    return into(records).insert(
      item.toCompanion(),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> remove(int id) async {
    await (delete(records)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ExtendedRecordModel>> getRecords(String collection) async {
    final items = await getRawRecords(collection);
    return items.map((item) => item.toModel()).toList();
  }

  Future<List<Record>> getRawRecords(String collection) async {
    final query = select(records)..where((t) => t.collectionName.equals(collection));
    final items = await query.get();
    return items;
  }

  /// Delete a single record for a given collection and id
  Future<void> deleteRecord(String collection, String id) async {
    final query = delete(records)
      ..where((t) => t.rowId.equals(id))
      ..where((t) => t.collectionName.equals(collection));
    await query.go();
  }

  /// Mark single record gor a given collection and id as unsynced deleted
  Future<void> markUnsyncedDeletedRecord(String collection, String id, PocketBaseErrorHandler? onError) async {
    final record = await getRecord(collection, id);
    if (record == null) {
      final error = 'could not mark unsynced deleted record $collection->$id because it could not be found in local database';
      onError?.call(error);
      return;
    }

    into(unsyncedDeletedRecords).insert(
      record.toUnsyncedDeletedCompanion(),
      mode: InsertMode.insertOrReplace,
    );
  }

  /// Deletes all records for a collection
  Future<void> deleteRecords(String collection) async {
    final query = delete(records)..where((t) => t.collectionName.equals(collection));
    await query.go();
  }

  Stream<List<ExtendedRecordModel>> watchRecords(String collection) {
    final query = select(records)..where((t) => t.collectionName.equals(collection));
    return query.watch().map((rows) => rows.map((row) => row.toModel()).toList());
  }

  Stream<ExtendedRecordModel?> watchRecord(String collection, String id) {
    final query = select(records)
      ..where((t) => t.rowId.equals(id))
      ..where((t) => t.collectionName.equals(collection));
    return query.watchSingleOrNull().map((row) {
      if (row != null) return row.toModel();
      return null;
    });
  }

  Future<List<ExtendedRecordModel>> searchAll(String query) async {
    final results = await _search(query).get();
    return results.fold<List<ExtendedRecordModel>>(<ExtendedRecordModel>[], (prev, item) {
      prev.add(item.r.toModel());
      return prev;
    });
  }

  Future<List<ExtendedRecordModel>> searchCollection(
    String query,
    String collection,
  ) async {
    final results = await searchAll(query);
    return results.where((item) => item.collectionName == collection).toList();
  }
}

class ExtendedRecordModel extends RecordModel {
  bool? unsyncedRead;
  bool? unsyncedCreation;
  bool? unsyncedUpdate;
  String? lastSyncUpdated;

  ExtendedRecordModel({
    id = "",
    created = "",
    updated = "",
    collectionId = "",
    collectionName = "",
    expand = const <String, List<RecordModel>>{},
    data = const <String, dynamic>{},
    this.unsyncedRead,
    this.unsyncedCreation,
    this.unsyncedUpdate,
    this.lastSyncUpdated,
  }) : super(id: id, created: created, updated: updated, collectionId: collectionId, collectionName: collectionName, expand: expand, data: data);

  RecordsCompanion toCompanion([int? currentId]) {
    return RecordsCompanion.insert(
      id: currentId != null ? Value(currentId) : const Value.absent(),
      rowId: id,
      collectionId: collectionId,
      collectionName: collectionName,
      data: toJson(),
      created: created,
      updated: updated,
      unsyncedRead: unsyncedRead == null ? const Value.absent() : Value.ofNullable(unsyncedRead!),
      unsyncedCreation: unsyncedCreation == null ? const Value.absent() : Value.ofNullable(unsyncedCreation!),
      unsyncedUpdate: unsyncedUpdate == null ? const Value.absent() : Value.ofNullable(unsyncedUpdate!),
      lastSyncUpdated: lastSyncUpdated == null ? const Value.absent() : Value.ofNullable(lastSyncUpdated!),
    );
  }

  UnsyncedDeletedRecordsCompanion toUnsyncedDeletedCompanion([int? currentId]) {
    return UnsyncedDeletedRecordsCompanion.insert(
      id: currentId != null ? Value(currentId) : const Value.absent(),
      rowId: id,
      collectionId: collectionId,
      collectionName: collectionName,
      data: toJson(),
      created: created,
      updated: updated,
      unsyncedRead: unsyncedRead == null ? const Value.absent() : Value.ofNullable(unsyncedRead!),
      unsyncedCreation: unsyncedCreation == null ? const Value.absent() : Value.ofNullable(unsyncedCreation!),
      unsyncedUpdate: unsyncedUpdate == null ? const Value.absent() : Value.ofNullable(unsyncedUpdate!),
      lastSyncUpdated: lastSyncUpdated == null ? const Value.absent() : Value.ofNullable(lastSyncUpdated!),
    );
  }
}

extension on Record {
  ExtendedRecordModel toModel() {
    return ExtendedRecordModel(
      id: rowId,
      collectionId: collectionId,
      collectionName: collectionName,
      data: data,
      created: created,
      updated: updated,
      unsyncedCreation: unsyncedCreation,
      unsyncedUpdate: unsyncedUpdate,
      lastSyncUpdated: lastSyncUpdated,
    );
  }
}
