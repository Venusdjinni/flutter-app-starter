// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistence.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String id;
  final DateTime creationDate;
  final DateTime? lastUpdateDate;
  User({required this.id, required this.creationDate, this.lastUpdateDate});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      creationDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}creation_date'])!,
      lastUpdateDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_update_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['creation_date'] = Variable<DateTime>(creationDate);
    if (!nullToAbsent || lastUpdateDate != null) {
      map['last_update_date'] = Variable<DateTime?>(lastUpdateDate);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      creationDate: Value(creationDate),
      lastUpdateDate: lastUpdateDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateDate),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['_id']),
      creationDate: serializer.fromJson<DateTime>(json['creation_date']),
      lastUpdateDate: serializer.fromJson<DateTime?>(json['last_update_date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      '_id': serializer.toJson<String>(id),
      'creation_date': serializer.toJson<DateTime>(creationDate),
      'last_update_date': serializer.toJson<DateTime?>(lastUpdateDate),
    };
  }

  User copyWith(
          {String? id, DateTime? creationDate, DateTime? lastUpdateDate}) =>
      User(
        id: id ?? this.id,
        creationDate: creationDate ?? this.creationDate,
        lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('creationDate: $creationDate, ')
          ..write('lastUpdateDate: $lastUpdateDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, creationDate, lastUpdateDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.creationDate == this.creationDate &&
          other.lastUpdateDate == this.lastUpdateDate);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<DateTime> creationDate;
  final Value<DateTime?> lastUpdateDate;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.lastUpdateDate = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required DateTime creationDate,
    this.lastUpdateDate = const Value.absent(),
  })  : id = Value(id),
        creationDate = Value(creationDate);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<DateTime>? creationDate,
    Expression<DateTime?>? lastUpdateDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creationDate != null) 'creation_date': creationDate,
      if (lastUpdateDate != null) 'last_update_date': lastUpdateDate,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? creationDate,
      Value<DateTime?>? lastUpdateDate}) {
    return UsersCompanion(
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (lastUpdateDate.present) {
      map['last_update_date'] = Variable<DateTime?>(lastUpdateDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('creationDate: $creationDate, ')
          ..write('lastUpdateDate: $lastUpdateDate')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _creationDateMeta =
      const VerificationMeta('creationDate');
  @override
  late final GeneratedColumn<DateTime?> creationDate =
      GeneratedColumn<DateTime?>('creation_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _lastUpdateDateMeta =
      const VerificationMeta('lastUpdateDate');
  @override
  late final GeneratedColumn<DateTime?> lastUpdateDate =
      GeneratedColumn<DateTime?>('last_update_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, creationDate, lastUpdateDate];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
          _creationDateMeta,
          creationDate.isAcceptableOrUnknown(
              data['creation_date']!, _creationDateMeta));
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('last_update_date')) {
      context.handle(
          _lastUpdateDateMeta,
          lastUpdateDate.isAcceptableOrUnknown(
              data['last_update_date']!, _lastUpdateDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}
