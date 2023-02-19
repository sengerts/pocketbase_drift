// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RecordsTable extends Records with TableInfo<$RecordsTable, Record> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<String> rowId = GeneratedColumn<String>(
      'row_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectionIdMeta =
      const VerificationMeta('collectionId');
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
      'collection_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectionNameMeta =
      const VerificationMeta('collectionName');
  @override
  late final GeneratedColumn<String> collectionName = GeneratedColumn<String>(
      'collection_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
      data = GeneratedColumn<String>('data', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, dynamic>>($RecordsTable.$converterdata);
  static const VerificationMeta _deletedMeta =
      const VerificationMeta('deleted');
  @override
  late final GeneratedColumn<bool> deleted =
      GeneratedColumn<bool>('deleted', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("deleted" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedMeta =
      const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String> updated = GeneratedColumn<String>(
      'updated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unsyncedReadMeta =
      const VerificationMeta('unsyncedRead');
  @override
  late final GeneratedColumn<bool> unsyncedRead =
      GeneratedColumn<bool>('unsynced_read', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("unsynced_read" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _unsyncedCreationMeta =
      const VerificationMeta('unsyncedCreation');
  @override
  late final GeneratedColumn<bool> unsyncedCreation =
      GeneratedColumn<bool>('unsynced_creation', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("unsynced_creation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _unsyncedUpdateMeta =
      const VerificationMeta('unsyncedUpdate');
  @override
  late final GeneratedColumn<bool> unsyncedUpdate =
      GeneratedColumn<bool>('unsynced_update', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("unsynced_update" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _lastSyncUpdatedMeta =
      const VerificationMeta('lastSyncUpdated');
  @override
  late final GeneratedColumn<String> lastSyncUpdated = GeneratedColumn<String>(
      'last_sync_updated', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        rowId,
        collectionId,
        collectionName,
        data,
        deleted,
        created,
        updated,
        unsyncedRead,
        unsyncedCreation,
        unsyncedUpdate,
        lastSyncUpdated
      ];
  @override
  String get aliasedName => _alias ?? 'records';
  @override
  String get actualTableName => 'records';
  @override
  VerificationContext validateIntegrity(Insertable<Record> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('row_id')) {
      context.handle(
          _rowIdMeta, rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta));
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
          _collectionIdMeta,
          collectionId.isAcceptableOrUnknown(
              data['collection_id']!, _collectionIdMeta));
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('collection_name')) {
      context.handle(
          _collectionNameMeta,
          collectionName.isAcceptableOrUnknown(
              data['collection_name']!, _collectionNameMeta));
    } else if (isInserting) {
      context.missing(_collectionNameMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('unsynced_read')) {
      context.handle(
          _unsyncedReadMeta,
          unsyncedRead.isAcceptableOrUnknown(
              data['unsynced_read']!, _unsyncedReadMeta));
    }
    if (data.containsKey('unsynced_creation')) {
      context.handle(
          _unsyncedCreationMeta,
          unsyncedCreation.isAcceptableOrUnknown(
              data['unsynced_creation']!, _unsyncedCreationMeta));
    }
    if (data.containsKey('unsynced_update')) {
      context.handle(
          _unsyncedUpdateMeta,
          unsyncedUpdate.isAcceptableOrUnknown(
              data['unsynced_update']!, _unsyncedUpdateMeta));
    }
    if (data.containsKey('last_sync_updated')) {
      context.handle(
          _lastSyncUpdatedMeta,
          lastSyncUpdated.isAcceptableOrUnknown(
              data['last_sync_updated']!, _lastSyncUpdatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {collectionId, rowId},
      ];
  @override
  Record map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Record(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      rowId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}row_id'])!,
      collectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collection_id'])!,
      collectionName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}collection_name'])!,
      data: $RecordsTable.$converterdata.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!),
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}deleted']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created'])!,
      updated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated'])!,
      unsyncedRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unsynced_read']),
      unsyncedCreation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unsynced_creation']),
      unsyncedUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unsynced_update']),
      lastSyncUpdated: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_sync_updated']),
    );
  }

  @override
  $RecordsTable createAlias(String alias) {
    return $RecordsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterdata =
      const JsonMapper();
}

class Record extends DataClass implements Insertable<Record> {
  final int id;
  final String rowId;
  final String collectionId;
  final String collectionName;
  final Map<String, dynamic> data;
  final bool? deleted;
  final String created;
  final String updated;
  final bool? unsyncedRead;
  final bool? unsyncedCreation;
  final bool? unsyncedUpdate;
  final String? lastSyncUpdated;
  const Record(
      {required this.id,
      required this.rowId,
      required this.collectionId,
      required this.collectionName,
      required this.data,
      this.deleted,
      required this.created,
      required this.updated,
      this.unsyncedRead,
      this.unsyncedCreation,
      this.unsyncedUpdate,
      this.lastSyncUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['row_id'] = Variable<String>(rowId);
    map['collection_id'] = Variable<String>(collectionId);
    map['collection_name'] = Variable<String>(collectionName);
    {
      final converter = $RecordsTable.$converterdata;
      map['data'] = Variable<String>(converter.toSql(data));
    }
    if (!nullToAbsent || deleted != null) {
      map['deleted'] = Variable<bool>(deleted);
    }
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    if (!nullToAbsent || unsyncedRead != null) {
      map['unsynced_read'] = Variable<bool>(unsyncedRead);
    }
    if (!nullToAbsent || unsyncedCreation != null) {
      map['unsynced_creation'] = Variable<bool>(unsyncedCreation);
    }
    if (!nullToAbsent || unsyncedUpdate != null) {
      map['unsynced_update'] = Variable<bool>(unsyncedUpdate);
    }
    if (!nullToAbsent || lastSyncUpdated != null) {
      map['last_sync_updated'] = Variable<String>(lastSyncUpdated);
    }
    return map;
  }

  RecordsCompanion toCompanion(bool nullToAbsent) {
    return RecordsCompanion(
      id: Value(id),
      rowId: Value(rowId),
      collectionId: Value(collectionId),
      collectionName: Value(collectionName),
      data: Value(data),
      deleted: deleted == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted),
      created: Value(created),
      updated: Value(updated),
      unsyncedRead: unsyncedRead == null && nullToAbsent
          ? const Value.absent()
          : Value(unsyncedRead),
      unsyncedCreation: unsyncedCreation == null && nullToAbsent
          ? const Value.absent()
          : Value(unsyncedCreation),
      unsyncedUpdate: unsyncedUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(unsyncedUpdate),
      lastSyncUpdated: lastSyncUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncUpdated),
    );
  }

  factory Record.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Record(
      id: serializer.fromJson<int>(json['id']),
      rowId: serializer.fromJson<String>(json['rowId']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      collectionName: serializer.fromJson<String>(json['collectionName']),
      data: serializer.fromJson<Map<String, dynamic>>(json['data']),
      deleted: serializer.fromJson<bool?>(json['deleted']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
      unsyncedRead: serializer.fromJson<bool?>(json['unsyncedRead']),
      unsyncedCreation: serializer.fromJson<bool?>(json['unsyncedCreation']),
      unsyncedUpdate: serializer.fromJson<bool?>(json['unsyncedUpdate']),
      lastSyncUpdated: serializer.fromJson<String?>(json['lastSyncUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rowId': serializer.toJson<String>(rowId),
      'collectionId': serializer.toJson<String>(collectionId),
      'collectionName': serializer.toJson<String>(collectionName),
      'data': serializer.toJson<Map<String, dynamic>>(data),
      'deleted': serializer.toJson<bool?>(deleted),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
      'unsyncedRead': serializer.toJson<bool?>(unsyncedRead),
      'unsyncedCreation': serializer.toJson<bool?>(unsyncedCreation),
      'unsyncedUpdate': serializer.toJson<bool?>(unsyncedUpdate),
      'lastSyncUpdated': serializer.toJson<String?>(lastSyncUpdated),
    };
  }

  Record copyWith(
          {int? id,
          String? rowId,
          String? collectionId,
          String? collectionName,
          Map<String, dynamic>? data,
          Value<bool?> deleted = const Value.absent(),
          String? created,
          String? updated,
          Value<bool?> unsyncedRead = const Value.absent(),
          Value<bool?> unsyncedCreation = const Value.absent(),
          Value<bool?> unsyncedUpdate = const Value.absent(),
          Value<String?> lastSyncUpdated = const Value.absent()}) =>
      Record(
        id: id ?? this.id,
        rowId: rowId ?? this.rowId,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        data: data ?? this.data,
        deleted: deleted.present ? deleted.value : this.deleted,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        unsyncedRead:
            unsyncedRead.present ? unsyncedRead.value : this.unsyncedRead,
        unsyncedCreation: unsyncedCreation.present
            ? unsyncedCreation.value
            : this.unsyncedCreation,
        unsyncedUpdate:
            unsyncedUpdate.present ? unsyncedUpdate.value : this.unsyncedUpdate,
        lastSyncUpdated: lastSyncUpdated.present
            ? lastSyncUpdated.value
            : this.lastSyncUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('Record(')
          ..write('id: $id, ')
          ..write('rowId: $rowId, ')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('data: $data, ')
          ..write('deleted: $deleted, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('unsyncedRead: $unsyncedRead, ')
          ..write('unsyncedCreation: $unsyncedCreation, ')
          ..write('unsyncedUpdate: $unsyncedUpdate, ')
          ..write('lastSyncUpdated: $lastSyncUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      rowId,
      collectionId,
      collectionName,
      data,
      deleted,
      created,
      updated,
      unsyncedRead,
      unsyncedCreation,
      unsyncedUpdate,
      lastSyncUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Record &&
          other.id == this.id &&
          other.rowId == this.rowId &&
          other.collectionId == this.collectionId &&
          other.collectionName == this.collectionName &&
          other.data == this.data &&
          other.deleted == this.deleted &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.unsyncedRead == this.unsyncedRead &&
          other.unsyncedCreation == this.unsyncedCreation &&
          other.unsyncedUpdate == this.unsyncedUpdate &&
          other.lastSyncUpdated == this.lastSyncUpdated);
}

class RecordsCompanion extends UpdateCompanion<Record> {
  final Value<int> id;
  final Value<String> rowId;
  final Value<String> collectionId;
  final Value<String> collectionName;
  final Value<Map<String, dynamic>> data;
  final Value<bool?> deleted;
  final Value<String> created;
  final Value<String> updated;
  final Value<bool?> unsyncedRead;
  final Value<bool?> unsyncedCreation;
  final Value<bool?> unsyncedUpdate;
  final Value<String?> lastSyncUpdated;
  const RecordsCompanion({
    this.id = const Value.absent(),
    this.rowId = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.collectionName = const Value.absent(),
    this.data = const Value.absent(),
    this.deleted = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.unsyncedRead = const Value.absent(),
    this.unsyncedCreation = const Value.absent(),
    this.unsyncedUpdate = const Value.absent(),
    this.lastSyncUpdated = const Value.absent(),
  });
  RecordsCompanion.insert({
    this.id = const Value.absent(),
    required String rowId,
    required String collectionId,
    required String collectionName,
    required Map<String, dynamic> data,
    this.deleted = const Value.absent(),
    required String created,
    required String updated,
    this.unsyncedRead = const Value.absent(),
    this.unsyncedCreation = const Value.absent(),
    this.unsyncedUpdate = const Value.absent(),
    this.lastSyncUpdated = const Value.absent(),
  })  : rowId = Value(rowId),
        collectionId = Value(collectionId),
        collectionName = Value(collectionName),
        data = Value(data),
        created = Value(created),
        updated = Value(updated);
  static Insertable<Record> custom({
    Expression<int>? id,
    Expression<String>? rowId,
    Expression<String>? collectionId,
    Expression<String>? collectionName,
    Expression<String>? data,
    Expression<bool>? deleted,
    Expression<String>? created,
    Expression<String>? updated,
    Expression<bool>? unsyncedRead,
    Expression<bool>? unsyncedCreation,
    Expression<bool>? unsyncedUpdate,
    Expression<String>? lastSyncUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowId != null) 'row_id': rowId,
      if (collectionId != null) 'collection_id': collectionId,
      if (collectionName != null) 'collection_name': collectionName,
      if (data != null) 'data': data,
      if (deleted != null) 'deleted': deleted,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (unsyncedRead != null) 'unsynced_read': unsyncedRead,
      if (unsyncedCreation != null) 'unsynced_creation': unsyncedCreation,
      if (unsyncedUpdate != null) 'unsynced_update': unsyncedUpdate,
      if (lastSyncUpdated != null) 'last_sync_updated': lastSyncUpdated,
    });
  }

  RecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? rowId,
      Value<String>? collectionId,
      Value<String>? collectionName,
      Value<Map<String, dynamic>>? data,
      Value<bool?>? deleted,
      Value<String>? created,
      Value<String>? updated,
      Value<bool?>? unsyncedRead,
      Value<bool?>? unsyncedCreation,
      Value<bool?>? unsyncedUpdate,
      Value<String?>? lastSyncUpdated}) {
    return RecordsCompanion(
      id: id ?? this.id,
      rowId: rowId ?? this.rowId,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      data: data ?? this.data,
      deleted: deleted ?? this.deleted,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      unsyncedRead: unsyncedRead ?? this.unsyncedRead,
      unsyncedCreation: unsyncedCreation ?? this.unsyncedCreation,
      unsyncedUpdate: unsyncedUpdate ?? this.unsyncedUpdate,
      lastSyncUpdated: lastSyncUpdated ?? this.lastSyncUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rowId.present) {
      map['row_id'] = Variable<String>(rowId.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (collectionName.present) {
      map['collection_name'] = Variable<String>(collectionName.value);
    }
    if (data.present) {
      final converter = $RecordsTable.$converterdata;
      map['data'] = Variable<String>(converter.toSql(data.value));
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    if (unsyncedRead.present) {
      map['unsynced_read'] = Variable<bool>(unsyncedRead.value);
    }
    if (unsyncedCreation.present) {
      map['unsynced_creation'] = Variable<bool>(unsyncedCreation.value);
    }
    if (unsyncedUpdate.present) {
      map['unsynced_update'] = Variable<bool>(unsyncedUpdate.value);
    }
    if (lastSyncUpdated.present) {
      map['last_sync_updated'] = Variable<String>(lastSyncUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordsCompanion(')
          ..write('id: $id, ')
          ..write('rowId: $rowId, ')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('data: $data, ')
          ..write('deleted: $deleted, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('unsyncedRead: $unsyncedRead, ')
          ..write('unsyncedCreation: $unsyncedCreation, ')
          ..write('unsyncedUpdate: $unsyncedUpdate, ')
          ..write('lastSyncUpdated: $lastSyncUpdated')
          ..write(')'))
        .toString();
  }
}

class TextEntries extends Table
    with
        TableInfo<TextEntries, TextEntrie>,
        VirtualTableInfo<TextEntries, TextEntrie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TextEntries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [data];
  @override
  String get aliasedName => _alias ?? 'text_entries';
  @override
  String get actualTableName => 'text_entries';
  @override
  VerificationContext validateIntegrity(Insertable<TextEntrie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TextEntrie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TextEntrie(
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
    );
  }

  @override
  TextEntries createAlias(String alias) {
    return TextEntries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs => 'fts5(data, content=records, content_rowid=id)';
}

class TextEntrie extends DataClass implements Insertable<TextEntrie> {
  final String data;
  const TextEntrie({required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['data'] = Variable<String>(data);
    return map;
  }

  TextEntriesCompanion toCompanion(bool nullToAbsent) {
    return TextEntriesCompanion(
      data: Value(data),
    );
  }

  factory TextEntrie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TextEntrie(
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'data': serializer.toJson<String>(data),
    };
  }

  TextEntrie copyWith({String? data}) => TextEntrie(
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('TextEntrie(')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => data.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextEntrie && other.data == this.data);
}

class TextEntriesCompanion extends UpdateCompanion<TextEntrie> {
  final Value<String> data;
  const TextEntriesCompanion({
    this.data = const Value.absent(),
  });
  TextEntriesCompanion.insert({
    required String data,
  }) : data = Value(data);
  static Insertable<TextEntrie> custom({
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (data != null) 'data': data,
    });
  }

  TextEntriesCompanion copyWith({Value<String>? data}) {
    return TextEntriesCompanion(
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextEntriesCompanion(')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $UnsyncedDeletedRecordsTable extends UnsyncedDeletedRecords
    with TableInfo<$UnsyncedDeletedRecordsTable, UnsyncedDeletedRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnsyncedDeletedRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<String> rowId = GeneratedColumn<String>(
      'row_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectionIdMeta =
      const VerificationMeta('collectionId');
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
      'collection_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectionNameMeta =
      const VerificationMeta('collectionName');
  @override
  late final GeneratedColumn<String> collectionName = GeneratedColumn<String>(
      'collection_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
      data = GeneratedColumn<String>('data', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, dynamic>>(
              $UnsyncedDeletedRecordsTable.$converterdata);
  static const VerificationMeta _deletedMeta =
      const VerificationMeta('deleted');
  @override
  late final GeneratedColumn<bool> deleted =
      GeneratedColumn<bool>('deleted', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("deleted" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _createdMeta =
      const VerificationMeta('created');
  @override
  late final GeneratedColumn<String> created = GeneratedColumn<String>(
      'created', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedMeta =
      const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String> updated = GeneratedColumn<String>(
      'updated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unsyncedReadMeta =
      const VerificationMeta('unsyncedRead');
  @override
  late final GeneratedColumn<bool> unsyncedRead =
      GeneratedColumn<bool>('unsynced_read', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("unsynced_read" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _unsyncedCreationMeta =
      const VerificationMeta('unsyncedCreation');
  @override
  late final GeneratedColumn<bool> unsyncedCreation =
      GeneratedColumn<bool>('unsynced_creation', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("unsynced_creation" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _unsyncedUpdateMeta =
      const VerificationMeta('unsyncedUpdate');
  @override
  late final GeneratedColumn<bool> unsyncedUpdate =
      GeneratedColumn<bool>('unsynced_update', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("unsynced_update" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _lastSyncUpdatedMeta =
      const VerificationMeta('lastSyncUpdated');
  @override
  late final GeneratedColumn<String> lastSyncUpdated = GeneratedColumn<String>(
      'last_sync_updated', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  List<GeneratedColumn> get $columns => [
        rowId,
        collectionId,
        collectionName,
        data,
        deleted,
        created,
        updated,
        unsyncedRead,
        unsyncedCreation,
        unsyncedUpdate,
        lastSyncUpdated,
        id
      ];
  @override
  String get aliasedName => _alias ?? 'unsynced_deleted_records';
  @override
  String get actualTableName => 'unsynced_deleted_records';
  @override
  VerificationContext validateIntegrity(
      Insertable<UnsyncedDeletedRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
          _rowIdMeta, rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta));
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
          _collectionIdMeta,
          collectionId.isAcceptableOrUnknown(
              data['collection_id']!, _collectionIdMeta));
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('collection_name')) {
      context.handle(
          _collectionNameMeta,
          collectionName.isAcceptableOrUnknown(
              data['collection_name']!, _collectionNameMeta));
    } else if (isInserting) {
      context.missing(_collectionNameMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('unsynced_read')) {
      context.handle(
          _unsyncedReadMeta,
          unsyncedRead.isAcceptableOrUnknown(
              data['unsynced_read']!, _unsyncedReadMeta));
    }
    if (data.containsKey('unsynced_creation')) {
      context.handle(
          _unsyncedCreationMeta,
          unsyncedCreation.isAcceptableOrUnknown(
              data['unsynced_creation']!, _unsyncedCreationMeta));
    }
    if (data.containsKey('unsynced_update')) {
      context.handle(
          _unsyncedUpdateMeta,
          unsyncedUpdate.isAcceptableOrUnknown(
              data['unsynced_update']!, _unsyncedUpdateMeta));
    }
    if (data.containsKey('last_sync_updated')) {
      context.handle(
          _lastSyncUpdatedMeta,
          lastSyncUpdated.isAcceptableOrUnknown(
              data['last_sync_updated']!, _lastSyncUpdatedMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {collectionId, rowId},
      ];
  @override
  UnsyncedDeletedRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnsyncedDeletedRecord(
      rowId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}row_id'])!,
      collectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collection_id'])!,
      collectionName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}collection_name'])!,
      data: $UnsyncedDeletedRecordsTable.$converterdata.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!),
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}deleted']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created'])!,
      updated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated'])!,
      unsyncedRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unsynced_read']),
      unsyncedCreation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unsynced_creation']),
      unsyncedUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unsynced_update']),
      lastSyncUpdated: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_sync_updated']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $UnsyncedDeletedRecordsTable createAlias(String alias) {
    return $UnsyncedDeletedRecordsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterdata =
      const JsonMapper();
}

class UnsyncedDeletedRecord extends DataClass
    implements Insertable<UnsyncedDeletedRecord> {
  final String rowId;
  final String collectionId;
  final String collectionName;
  final Map<String, dynamic> data;
  final bool? deleted;
  final String created;
  final String updated;
  final bool? unsyncedRead;
  final bool? unsyncedCreation;
  final bool? unsyncedUpdate;
  final String? lastSyncUpdated;
  final int id;
  const UnsyncedDeletedRecord(
      {required this.rowId,
      required this.collectionId,
      required this.collectionName,
      required this.data,
      this.deleted,
      required this.created,
      required this.updated,
      this.unsyncedRead,
      this.unsyncedCreation,
      this.unsyncedUpdate,
      this.lastSyncUpdated,
      required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<String>(rowId);
    map['collection_id'] = Variable<String>(collectionId);
    map['collection_name'] = Variable<String>(collectionName);
    {
      final converter = $UnsyncedDeletedRecordsTable.$converterdata;
      map['data'] = Variable<String>(converter.toSql(data));
    }
    if (!nullToAbsent || deleted != null) {
      map['deleted'] = Variable<bool>(deleted);
    }
    map['created'] = Variable<String>(created);
    map['updated'] = Variable<String>(updated);
    if (!nullToAbsent || unsyncedRead != null) {
      map['unsynced_read'] = Variable<bool>(unsyncedRead);
    }
    if (!nullToAbsent || unsyncedCreation != null) {
      map['unsynced_creation'] = Variable<bool>(unsyncedCreation);
    }
    if (!nullToAbsent || unsyncedUpdate != null) {
      map['unsynced_update'] = Variable<bool>(unsyncedUpdate);
    }
    if (!nullToAbsent || lastSyncUpdated != null) {
      map['last_sync_updated'] = Variable<String>(lastSyncUpdated);
    }
    map['id'] = Variable<int>(id);
    return map;
  }

  UnsyncedDeletedRecordsCompanion toCompanion(bool nullToAbsent) {
    return UnsyncedDeletedRecordsCompanion(
      rowId: Value(rowId),
      collectionId: Value(collectionId),
      collectionName: Value(collectionName),
      data: Value(data),
      deleted: deleted == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted),
      created: Value(created),
      updated: Value(updated),
      unsyncedRead: unsyncedRead == null && nullToAbsent
          ? const Value.absent()
          : Value(unsyncedRead),
      unsyncedCreation: unsyncedCreation == null && nullToAbsent
          ? const Value.absent()
          : Value(unsyncedCreation),
      unsyncedUpdate: unsyncedUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(unsyncedUpdate),
      lastSyncUpdated: lastSyncUpdated == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncUpdated),
      id: Value(id),
    );
  }

  factory UnsyncedDeletedRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnsyncedDeletedRecord(
      rowId: serializer.fromJson<String>(json['rowId']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      collectionName: serializer.fromJson<String>(json['collectionName']),
      data: serializer.fromJson<Map<String, dynamic>>(json['data']),
      deleted: serializer.fromJson<bool?>(json['deleted']),
      created: serializer.fromJson<String>(json['created']),
      updated: serializer.fromJson<String>(json['updated']),
      unsyncedRead: serializer.fromJson<bool?>(json['unsyncedRead']),
      unsyncedCreation: serializer.fromJson<bool?>(json['unsyncedCreation']),
      unsyncedUpdate: serializer.fromJson<bool?>(json['unsyncedUpdate']),
      lastSyncUpdated: serializer.fromJson<String?>(json['lastSyncUpdated']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<String>(rowId),
      'collectionId': serializer.toJson<String>(collectionId),
      'collectionName': serializer.toJson<String>(collectionName),
      'data': serializer.toJson<Map<String, dynamic>>(data),
      'deleted': serializer.toJson<bool?>(deleted),
      'created': serializer.toJson<String>(created),
      'updated': serializer.toJson<String>(updated),
      'unsyncedRead': serializer.toJson<bool?>(unsyncedRead),
      'unsyncedCreation': serializer.toJson<bool?>(unsyncedCreation),
      'unsyncedUpdate': serializer.toJson<bool?>(unsyncedUpdate),
      'lastSyncUpdated': serializer.toJson<String?>(lastSyncUpdated),
      'id': serializer.toJson<int>(id),
    };
  }

  UnsyncedDeletedRecord copyWith(
          {String? rowId,
          String? collectionId,
          String? collectionName,
          Map<String, dynamic>? data,
          Value<bool?> deleted = const Value.absent(),
          String? created,
          String? updated,
          Value<bool?> unsyncedRead = const Value.absent(),
          Value<bool?> unsyncedCreation = const Value.absent(),
          Value<bool?> unsyncedUpdate = const Value.absent(),
          Value<String?> lastSyncUpdated = const Value.absent(),
          int? id}) =>
      UnsyncedDeletedRecord(
        rowId: rowId ?? this.rowId,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        data: data ?? this.data,
        deleted: deleted.present ? deleted.value : this.deleted,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        unsyncedRead:
            unsyncedRead.present ? unsyncedRead.value : this.unsyncedRead,
        unsyncedCreation: unsyncedCreation.present
            ? unsyncedCreation.value
            : this.unsyncedCreation,
        unsyncedUpdate:
            unsyncedUpdate.present ? unsyncedUpdate.value : this.unsyncedUpdate,
        lastSyncUpdated: lastSyncUpdated.present
            ? lastSyncUpdated.value
            : this.lastSyncUpdated,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('UnsyncedDeletedRecord(')
          ..write('rowId: $rowId, ')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('data: $data, ')
          ..write('deleted: $deleted, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('unsyncedRead: $unsyncedRead, ')
          ..write('unsyncedCreation: $unsyncedCreation, ')
          ..write('unsyncedUpdate: $unsyncedUpdate, ')
          ..write('lastSyncUpdated: $lastSyncUpdated, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      rowId,
      collectionId,
      collectionName,
      data,
      deleted,
      created,
      updated,
      unsyncedRead,
      unsyncedCreation,
      unsyncedUpdate,
      lastSyncUpdated,
      id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnsyncedDeletedRecord &&
          other.rowId == this.rowId &&
          other.collectionId == this.collectionId &&
          other.collectionName == this.collectionName &&
          other.data == this.data &&
          other.deleted == this.deleted &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.unsyncedRead == this.unsyncedRead &&
          other.unsyncedCreation == this.unsyncedCreation &&
          other.unsyncedUpdate == this.unsyncedUpdate &&
          other.lastSyncUpdated == this.lastSyncUpdated &&
          other.id == this.id);
}

class UnsyncedDeletedRecordsCompanion
    extends UpdateCompanion<UnsyncedDeletedRecord> {
  final Value<String> rowId;
  final Value<String> collectionId;
  final Value<String> collectionName;
  final Value<Map<String, dynamic>> data;
  final Value<bool?> deleted;
  final Value<String> created;
  final Value<String> updated;
  final Value<bool?> unsyncedRead;
  final Value<bool?> unsyncedCreation;
  final Value<bool?> unsyncedUpdate;
  final Value<String?> lastSyncUpdated;
  final Value<int> id;
  const UnsyncedDeletedRecordsCompanion({
    this.rowId = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.collectionName = const Value.absent(),
    this.data = const Value.absent(),
    this.deleted = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.unsyncedRead = const Value.absent(),
    this.unsyncedCreation = const Value.absent(),
    this.unsyncedUpdate = const Value.absent(),
    this.lastSyncUpdated = const Value.absent(),
    this.id = const Value.absent(),
  });
  UnsyncedDeletedRecordsCompanion.insert({
    required String rowId,
    required String collectionId,
    required String collectionName,
    required Map<String, dynamic> data,
    this.deleted = const Value.absent(),
    required String created,
    required String updated,
    this.unsyncedRead = const Value.absent(),
    this.unsyncedCreation = const Value.absent(),
    this.unsyncedUpdate = const Value.absent(),
    this.lastSyncUpdated = const Value.absent(),
    this.id = const Value.absent(),
  })  : rowId = Value(rowId),
        collectionId = Value(collectionId),
        collectionName = Value(collectionName),
        data = Value(data),
        created = Value(created),
        updated = Value(updated);
  static Insertable<UnsyncedDeletedRecord> custom({
    Expression<String>? rowId,
    Expression<String>? collectionId,
    Expression<String>? collectionName,
    Expression<String>? data,
    Expression<bool>? deleted,
    Expression<String>? created,
    Expression<String>? updated,
    Expression<bool>? unsyncedRead,
    Expression<bool>? unsyncedCreation,
    Expression<bool>? unsyncedUpdate,
    Expression<String>? lastSyncUpdated,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (collectionId != null) 'collection_id': collectionId,
      if (collectionName != null) 'collection_name': collectionName,
      if (data != null) 'data': data,
      if (deleted != null) 'deleted': deleted,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (unsyncedRead != null) 'unsynced_read': unsyncedRead,
      if (unsyncedCreation != null) 'unsynced_creation': unsyncedCreation,
      if (unsyncedUpdate != null) 'unsynced_update': unsyncedUpdate,
      if (lastSyncUpdated != null) 'last_sync_updated': lastSyncUpdated,
      if (id != null) 'id': id,
    });
  }

  UnsyncedDeletedRecordsCompanion copyWith(
      {Value<String>? rowId,
      Value<String>? collectionId,
      Value<String>? collectionName,
      Value<Map<String, dynamic>>? data,
      Value<bool?>? deleted,
      Value<String>? created,
      Value<String>? updated,
      Value<bool?>? unsyncedRead,
      Value<bool?>? unsyncedCreation,
      Value<bool?>? unsyncedUpdate,
      Value<String?>? lastSyncUpdated,
      Value<int>? id}) {
    return UnsyncedDeletedRecordsCompanion(
      rowId: rowId ?? this.rowId,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      data: data ?? this.data,
      deleted: deleted ?? this.deleted,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      unsyncedRead: unsyncedRead ?? this.unsyncedRead,
      unsyncedCreation: unsyncedCreation ?? this.unsyncedCreation,
      unsyncedUpdate: unsyncedUpdate ?? this.unsyncedUpdate,
      lastSyncUpdated: lastSyncUpdated ?? this.lastSyncUpdated,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<String>(rowId.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (collectionName.present) {
      map['collection_name'] = Variable<String>(collectionName.value);
    }
    if (data.present) {
      final converter = $UnsyncedDeletedRecordsTable.$converterdata;
      map['data'] = Variable<String>(converter.toSql(data.value));
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (created.present) {
      map['created'] = Variable<String>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    if (unsyncedRead.present) {
      map['unsynced_read'] = Variable<bool>(unsyncedRead.value);
    }
    if (unsyncedCreation.present) {
      map['unsynced_creation'] = Variable<bool>(unsyncedCreation.value);
    }
    if (unsyncedUpdate.present) {
      map['unsynced_update'] = Variable<bool>(unsyncedUpdate.value);
    }
    if (lastSyncUpdated.present) {
      map['last_sync_updated'] = Variable<String>(lastSyncUpdated.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnsyncedDeletedRecordsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('data: $data, ')
          ..write('deleted: $deleted, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('unsyncedRead: $unsyncedRead, ')
          ..write('unsyncedCreation: $unsyncedCreation, ')
          ..write('unsyncedUpdate: $unsyncedUpdate, ')
          ..write('lastSyncUpdated: $lastSyncUpdated, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $LastFullCollectionSyncsTable extends LastFullCollectionSyncs
    with TableInfo<$LastFullCollectionSyncsTable, LastFullCollectionSync> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LastFullCollectionSyncsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _collectionIdMeta =
      const VerificationMeta('collectionId');
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
      'collection_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectionNameMeta =
      const VerificationMeta('collectionName');
  @override
  late final GeneratedColumn<String> collectionName = GeneratedColumn<String>(
      'collection_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filterMeta = const VerificationMeta('filter');
  @override
  late final GeneratedColumn<String> filter = GeneratedColumn<String>(
      'filter', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncTimestampMeta =
      const VerificationMeta('syncTimestamp');
  @override
  late final GeneratedColumn<DateTime> syncTimestamp =
      GeneratedColumn<DateTime>('sync_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, collectionId, collectionName, filter, syncTimestamp];
  @override
  String get aliasedName => _alias ?? 'last_full_collection_syncs';
  @override
  String get actualTableName => 'last_full_collection_syncs';
  @override
  VerificationContext validateIntegrity(
      Insertable<LastFullCollectionSync> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
          _collectionIdMeta,
          collectionId.isAcceptableOrUnknown(
              data['collection_id']!, _collectionIdMeta));
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('collection_name')) {
      context.handle(
          _collectionNameMeta,
          collectionName.isAcceptableOrUnknown(
              data['collection_name']!, _collectionNameMeta));
    } else if (isInserting) {
      context.missing(_collectionNameMeta);
    }
    if (data.containsKey('filter')) {
      context.handle(_filterMeta,
          filter.isAcceptableOrUnknown(data['filter']!, _filterMeta));
    }
    if (data.containsKey('sync_timestamp')) {
      context.handle(
          _syncTimestampMeta,
          syncTimestamp.isAcceptableOrUnknown(
              data['sync_timestamp']!, _syncTimestampMeta));
    } else if (isInserting) {
      context.missing(_syncTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {collectionId, filter, syncTimestamp},
      ];
  @override
  LastFullCollectionSync map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LastFullCollectionSync(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      collectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collection_id'])!,
      collectionName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}collection_name'])!,
      filter: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filter']),
      syncTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sync_timestamp'])!,
    );
  }

  @override
  $LastFullCollectionSyncsTable createAlias(String alias) {
    return $LastFullCollectionSyncsTable(attachedDatabase, alias);
  }
}

class LastFullCollectionSync extends DataClass
    implements Insertable<LastFullCollectionSync> {
  final int id;
  final String collectionId;
  final String collectionName;
  final String? filter;
  final DateTime syncTimestamp;
  const LastFullCollectionSync(
      {required this.id,
      required this.collectionId,
      required this.collectionName,
      this.filter,
      required this.syncTimestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['collection_name'] = Variable<String>(collectionName);
    if (!nullToAbsent || filter != null) {
      map['filter'] = Variable<String>(filter);
    }
    map['sync_timestamp'] = Variable<DateTime>(syncTimestamp);
    return map;
  }

  LastFullCollectionSyncsCompanion toCompanion(bool nullToAbsent) {
    return LastFullCollectionSyncsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      collectionName: Value(collectionName),
      filter:
          filter == null && nullToAbsent ? const Value.absent() : Value(filter),
      syncTimestamp: Value(syncTimestamp),
    );
  }

  factory LastFullCollectionSync.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LastFullCollectionSync(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      collectionName: serializer.fromJson<String>(json['collectionName']),
      filter: serializer.fromJson<String?>(json['filter']),
      syncTimestamp: serializer.fromJson<DateTime>(json['syncTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'collectionName': serializer.toJson<String>(collectionName),
      'filter': serializer.toJson<String?>(filter),
      'syncTimestamp': serializer.toJson<DateTime>(syncTimestamp),
    };
  }

  LastFullCollectionSync copyWith(
          {int? id,
          String? collectionId,
          String? collectionName,
          Value<String?> filter = const Value.absent(),
          DateTime? syncTimestamp}) =>
      LastFullCollectionSync(
        id: id ?? this.id,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        filter: filter.present ? filter.value : this.filter,
        syncTimestamp: syncTimestamp ?? this.syncTimestamp,
      );
  @override
  String toString() {
    return (StringBuffer('LastFullCollectionSync(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('filter: $filter, ')
          ..write('syncTimestamp: $syncTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, collectionId, collectionName, filter, syncTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastFullCollectionSync &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.collectionName == this.collectionName &&
          other.filter == this.filter &&
          other.syncTimestamp == this.syncTimestamp);
}

class LastFullCollectionSyncsCompanion
    extends UpdateCompanion<LastFullCollectionSync> {
  final Value<int> id;
  final Value<String> collectionId;
  final Value<String> collectionName;
  final Value<String?> filter;
  final Value<DateTime> syncTimestamp;
  const LastFullCollectionSyncsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.collectionName = const Value.absent(),
    this.filter = const Value.absent(),
    this.syncTimestamp = const Value.absent(),
  });
  LastFullCollectionSyncsCompanion.insert({
    this.id = const Value.absent(),
    required String collectionId,
    required String collectionName,
    this.filter = const Value.absent(),
    required DateTime syncTimestamp,
  })  : collectionId = Value(collectionId),
        collectionName = Value(collectionName),
        syncTimestamp = Value(syncTimestamp);
  static Insertable<LastFullCollectionSync> custom({
    Expression<int>? id,
    Expression<String>? collectionId,
    Expression<String>? collectionName,
    Expression<String>? filter,
    Expression<DateTime>? syncTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (collectionName != null) 'collection_name': collectionName,
      if (filter != null) 'filter': filter,
      if (syncTimestamp != null) 'sync_timestamp': syncTimestamp,
    });
  }

  LastFullCollectionSyncsCompanion copyWith(
      {Value<int>? id,
      Value<String>? collectionId,
      Value<String>? collectionName,
      Value<String?>? filter,
      Value<DateTime>? syncTimestamp}) {
    return LastFullCollectionSyncsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      filter: filter ?? this.filter,
      syncTimestamp: syncTimestamp ?? this.syncTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (collectionName.present) {
      map['collection_name'] = Variable<String>(collectionName.value);
    }
    if (filter.present) {
      map['filter'] = Variable<String>(filter.value);
    }
    if (syncTimestamp.present) {
      map['sync_timestamp'] = Variable<DateTime>(syncTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LastFullCollectionSyncsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('collectionName: $collectionName, ')
          ..write('filter: $filter, ')
          ..write('syncTimestamp: $syncTimestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$PocketBaseDatabase extends GeneratedDatabase {
  _$PocketBaseDatabase(QueryExecutor e) : super(e);
  _$PocketBaseDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $RecordsTable records = $RecordsTable(this);
  late final TextEntries textEntries = TextEntries(this);
  late final Trigger recordsInsert = Trigger(
      'CREATE TRIGGER records_insert AFTER INSERT ON records BEGIN INSERT INTO text_entries ("rowid", data) VALUES (new.id, new.data);END',
      'records_insert');
  late final Trigger recordsDelete = Trigger(
      'CREATE TRIGGER records_delete AFTER DELETE ON records BEGIN INSERT INTO text_entries (text_entries, "rowid", data) VALUES (\'delete\', old.id, old.data);END',
      'records_delete');
  late final Trigger recordsUpdate = Trigger(
      'CREATE TRIGGER records_update AFTER UPDATE ON records BEGIN INSERT INTO text_entries (text_entries, "rowid", data) VALUES (\'delete\', new.id, new.data);INSERT INTO text_entries ("rowid", data) VALUES (new.id, new.data);END',
      'records_update');
  late final $UnsyncedDeletedRecordsTable unsyncedDeletedRecords =
      $UnsyncedDeletedRecordsTable(this);
  late final $LastFullCollectionSyncsTable lastFullCollectionSyncs =
      $LastFullCollectionSyncsTable(this);
  Selectable<SearchResult> _search(String query) {
    return customSelect(
        'SELECT"r"."id" AS "nested_0.id", "r"."row_id" AS "nested_0.row_id", "r"."collection_id" AS "nested_0.collection_id", "r"."collection_name" AS "nested_0.collection_name", "r"."data" AS "nested_0.data", "r"."deleted" AS "nested_0.deleted", "r"."created" AS "nested_0.created", "r"."updated" AS "nested_0.updated", "r"."unsynced_read" AS "nested_0.unsynced_read", "r"."unsynced_creation" AS "nested_0.unsynced_creation", "r"."unsynced_update" AS "nested_0.unsynced_update", "r"."last_sync_updated" AS "nested_0.last_sync_updated" FROM text_entries INNER JOIN records AS r ON r.id = text_entries."rowid" WHERE text_entries MATCH ?1 ORDER BY rank',
        variables: [
          Variable<String>(query)
        ],
        readsFrom: {
          textEntries,
          records,
        }).asyncMap((QueryRow row) async {
      return SearchResult(
        r: await records.mapFromRow(row, tablePrefix: 'nested_0'),
      );
    });
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        records,
        textEntries,
        recordsInsert,
        recordsDelete,
        recordsUpdate,
        unsyncedDeletedRecords,
        lastFullCollectionSyncs
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('records',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('text_entries', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('text_entries', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('records',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('text_entries', kind: UpdateKind.insert),
            ],
          ),
        ],
      );
}

class SearchResult {
  final Record r;
  SearchResult({
    required this.r,
  });
}
