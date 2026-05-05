// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('beginner'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
      'salt', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, level, email, passwordHash, salt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt']!, _saltMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash']),
      salt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}salt']),
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final int id;
  final String name;
  final String level;
  final String? email;
  final String? passwordHash;
  final String? salt;
  const UserProfileData(
      {required this.id,
      required this.name,
      required this.level,
      this.email,
      this.passwordHash,
      this.salt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['level'] = Variable<String>(level);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    if (!nullToAbsent || salt != null) {
      map['salt'] = Variable<String>(salt);
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      level: Value(level),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      salt: salt == null && nullToAbsent ? const Value.absent() : Value(salt),
    );
  }

  factory UserProfileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      level: serializer.fromJson<String>(json['level']),
      email: serializer.fromJson<String?>(json['email']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      salt: serializer.fromJson<String?>(json['salt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'level': serializer.toJson<String>(level),
      'email': serializer.toJson<String?>(email),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'salt': serializer.toJson<String?>(salt),
    };
  }

  UserProfileData copyWith(
          {int? id,
          String? name,
          String? level,
          Value<String?> email = const Value.absent(),
          Value<String?> passwordHash = const Value.absent(),
          Value<String?> salt = const Value.absent()}) =>
      UserProfileData(
        id: id ?? this.id,
        name: name ?? this.name,
        level: level ?? this.level,
        email: email.present ? email.value : this.email,
        passwordHash:
            passwordHash.present ? passwordHash.value : this.passwordHash,
        salt: salt.present ? salt.value : this.salt,
      );
  UserProfileData copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      level: data.level.present ? data.level.value : this.level,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      salt: data.salt.present ? data.salt.value : this.salt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, level, email, passwordHash, salt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.id == this.id &&
          other.name == this.name &&
          other.level == this.level &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.salt == this.salt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> level;
  final Value<String?> email;
  final Value<String?> passwordHash;
  final Value<String?> salt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.level = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<UserProfileData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? level,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? salt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (level != null) 'level': level,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (salt != null) 'salt': salt,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? level,
      Value<String?>? email,
      Value<String?>? passwordHash,
      Value<String?>? salt}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt')
          ..write(')'))
        .toString();
  }
}

class $FocusAreasTable extends FocusAreas
    with TableInfo<$FocusAreasTable, FocusAreaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusAreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user_profiles (id)'));
  static const VerificationMeta _areaNameMeta =
      const VerificationMeta('areaName');
  @override
  late final GeneratedColumn<String> areaName = GeneratedColumn<String>(
      'area_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, areaName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_areas';
  @override
  VerificationContext validateIntegrity(Insertable<FocusAreaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('area_name')) {
      context.handle(_areaNameMeta,
          areaName.isAcceptableOrUnknown(data['area_name']!, _areaNameMeta));
    } else if (isInserting) {
      context.missing(_areaNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusAreaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusAreaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      areaName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_name'])!,
    );
  }

  @override
  $FocusAreasTable createAlias(String alias) {
    return $FocusAreasTable(attachedDatabase, alias);
  }
}

class FocusAreaData extends DataClass implements Insertable<FocusAreaData> {
  final int id;
  final int userId;
  final String areaName;
  const FocusAreaData(
      {required this.id, required this.userId, required this.areaName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['area_name'] = Variable<String>(areaName);
    return map;
  }

  FocusAreasCompanion toCompanion(bool nullToAbsent) {
    return FocusAreasCompanion(
      id: Value(id),
      userId: Value(userId),
      areaName: Value(areaName),
    );
  }

  factory FocusAreaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusAreaData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      areaName: serializer.fromJson<String>(json['areaName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'areaName': serializer.toJson<String>(areaName),
    };
  }

  FocusAreaData copyWith({int? id, int? userId, String? areaName}) =>
      FocusAreaData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        areaName: areaName ?? this.areaName,
      );
  FocusAreaData copyWithCompanion(FocusAreasCompanion data) {
    return FocusAreaData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      areaName: data.areaName.present ? data.areaName.value : this.areaName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusAreaData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('areaName: $areaName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, areaName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusAreaData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.areaName == this.areaName);
}

class FocusAreasCompanion extends UpdateCompanion<FocusAreaData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> areaName;
  const FocusAreasCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.areaName = const Value.absent(),
  });
  FocusAreasCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String areaName,
  })  : userId = Value(userId),
        areaName = Value(areaName);
  static Insertable<FocusAreaData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? areaName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (areaName != null) 'area_name': areaName,
    });
  }

  FocusAreasCompanion copyWith(
      {Value<int>? id, Value<int>? userId, Value<String>? areaName}) {
    return FocusAreasCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      areaName: areaName ?? this.areaName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (areaName.present) {
      map['area_name'] = Variable<String>(areaName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusAreasCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('areaName: $areaName')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions
    with TableInfo<$SessionsTable, SessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _streakDayMeta =
      const VerificationMeta('streakDay');
  @override
  late final GeneratedColumn<int> streakDay = GeneratedColumn<int>(
      'streak_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, durationSeconds, streakDay];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<SessionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('streak_day')) {
      context.handle(_streakDayMeta,
          streakDay.isAcceptableOrUnknown(data['streak_day']!, _streakDayMeta));
    } else if (isInserting) {
      context.missing(_streakDayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      streakDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_day'])!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class SessionData extends DataClass implements Insertable<SessionData> {
  final int id;
  final DateTime date;
  final int durationSeconds;
  final int streakDay;
  const SessionData(
      {required this.id,
      required this.date,
      required this.durationSeconds,
      required this.streakDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['streak_day'] = Variable<int>(streakDay);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      date: Value(date),
      durationSeconds: Value(durationSeconds),
      streakDay: Value(streakDay),
    );
  }

  factory SessionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      streakDay: serializer.fromJson<int>(json['streakDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'streakDay': serializer.toJson<int>(streakDay),
    };
  }

  SessionData copyWith(
          {int? id, DateTime? date, int? durationSeconds, int? streakDay}) =>
      SessionData(
        id: id ?? this.id,
        date: date ?? this.date,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        streakDay: streakDay ?? this.streakDay,
      );
  SessionData copyWithCompanion(SessionsCompanion data) {
    return SessionData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      streakDay: data.streakDay.present ? data.streakDay.value : this.streakDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('streakDay: $streakDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, durationSeconds, streakDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionData &&
          other.id == this.id &&
          other.date == this.date &&
          other.durationSeconds == this.durationSeconds &&
          other.streakDay == this.streakDay);
}

class SessionsCompanion extends UpdateCompanion<SessionData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> durationSeconds;
  final Value<int> streakDay;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.streakDay = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int durationSeconds,
    required int streakDay,
  })  : date = Value(date),
        durationSeconds = Value(durationSeconds),
        streakDay = Value(streakDay);
  static Insertable<SessionData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? durationSeconds,
    Expression<int>? streakDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (streakDay != null) 'streak_day': streakDay,
    });
  }

  SessionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? durationSeconds,
      Value<int>? streakDay}) {
    return SessionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      streakDay: streakDay ?? this.streakDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (streakDay.present) {
      map['streak_day'] = Variable<int>(streakDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('streakDay: $streakDay')
          ..write(')'))
        .toString();
  }
}

class $SessionStretchesTable extends SessionStretches
    with TableInfo<$SessionStretchesTable, SessionStretchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionStretchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _stretchNameMeta =
      const VerificationMeta('stretchName');
  @override
  late final GeneratedColumn<String> stretchName = GeneratedColumn<String>(
      'stretch_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _feedbackMeta =
      const VerificationMeta('feedback');
  @override
  late final GeneratedColumn<String> feedback = GeneratedColumn<String>(
      'feedback', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionId, stretchName, durationSeconds, feedback];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_stretches';
  @override
  VerificationContext validateIntegrity(Insertable<SessionStretchData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('stretch_name')) {
      context.handle(
          _stretchNameMeta,
          stretchName.isAcceptableOrUnknown(
              data['stretch_name']!, _stretchNameMeta));
    } else if (isInserting) {
      context.missing(_stretchNameMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('feedback')) {
      context.handle(_feedbackMeta,
          feedback.isAcceptableOrUnknown(data['feedback']!, _feedbackMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionStretchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionStretchData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id'])!,
      stretchName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stretch_name'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      feedback: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feedback']),
    );
  }

  @override
  $SessionStretchesTable createAlias(String alias) {
    return $SessionStretchesTable(attachedDatabase, alias);
  }
}

class SessionStretchData extends DataClass
    implements Insertable<SessionStretchData> {
  final int id;
  final int sessionId;
  final String stretchName;
  final int durationSeconds;
  final String? feedback;
  const SessionStretchData(
      {required this.id,
      required this.sessionId,
      required this.stretchName,
      required this.durationSeconds,
      this.feedback});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['stretch_name'] = Variable<String>(stretchName);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(feedback);
    }
    return map;
  }

  SessionStretchesCompanion toCompanion(bool nullToAbsent) {
    return SessionStretchesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      stretchName: Value(stretchName),
      durationSeconds: Value(durationSeconds),
      feedback: feedback == null && nullToAbsent
          ? const Value.absent()
          : Value(feedback),
    );
  }

  factory SessionStretchData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionStretchData(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      stretchName: serializer.fromJson<String>(json['stretchName']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      feedback: serializer.fromJson<String?>(json['feedback']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'stretchName': serializer.toJson<String>(stretchName),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'feedback': serializer.toJson<String?>(feedback),
    };
  }

  SessionStretchData copyWith(
          {int? id,
          int? sessionId,
          String? stretchName,
          int? durationSeconds,
          Value<String?> feedback = const Value.absent()}) =>
      SessionStretchData(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        stretchName: stretchName ?? this.stretchName,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        feedback: feedback.present ? feedback.value : this.feedback,
      );
  SessionStretchData copyWithCompanion(SessionStretchesCompanion data) {
    return SessionStretchData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      stretchName:
          data.stretchName.present ? data.stretchName.value : this.stretchName,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionStretchData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('stretchName: $stretchName, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('feedback: $feedback')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, stretchName, durationSeconds, feedback);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionStretchData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.stretchName == this.stretchName &&
          other.durationSeconds == this.durationSeconds &&
          other.feedback == this.feedback);
}

class SessionStretchesCompanion extends UpdateCompanion<SessionStretchData> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<String> stretchName;
  final Value<int> durationSeconds;
  final Value<String?> feedback;
  const SessionStretchesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.stretchName = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.feedback = const Value.absent(),
  });
  SessionStretchesCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required String stretchName,
    required int durationSeconds,
    this.feedback = const Value.absent(),
  })  : sessionId = Value(sessionId),
        stretchName = Value(stretchName),
        durationSeconds = Value(durationSeconds);
  static Insertable<SessionStretchData> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<String>? stretchName,
    Expression<int>? durationSeconds,
    Expression<String>? feedback,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (stretchName != null) 'stretch_name': stretchName,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (feedback != null) 'feedback': feedback,
    });
  }

  SessionStretchesCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionId,
      Value<String>? stretchName,
      Value<int>? durationSeconds,
      Value<String?>? feedback}) {
    return SessionStretchesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      stretchName: stretchName ?? this.stretchName,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      feedback: feedback ?? this.feedback,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (stretchName.present) {
      map['stretch_name'] = Variable<String>(stretchName.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionStretchesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('stretchName: $stretchName, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('feedback: $feedback')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $FocusAreasTable focusAreas = $FocusAreasTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionStretchesTable sessionStretches =
      $SessionStretchesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userProfiles, focusAreas, sessions, sessionStretches];
}

typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String> level,
  Value<String?> email,
  Value<String?> passwordHash,
  Value<String?> salt,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> level,
  Value<String?> email,
  Value<String?> passwordHash,
  Value<String?> salt,
});

final class $$UserProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileData> {
  $$UserProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FocusAreasTable, List<FocusAreaData>>
      _focusAreasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.focusAreas,
          aliasName:
              $_aliasNameGenerator(db.userProfiles.id, db.focusAreas.userId));

  $$FocusAreasTableProcessedTableManager get focusAreasRefs {
    final manager = $$FocusAreasTableTableManager($_db, $_db.focusAreas)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_focusAreasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnFilters(column));

  Expression<bool> focusAreasRefs(
      Expression<bool> Function($$FocusAreasTableFilterComposer f) f) {
    final $$FocusAreasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.focusAreas,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FocusAreasTableFilterComposer(
              $db: $db,
              $table: $db.focusAreas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salt => $composableBuilder(
      column: $table.salt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  Expression<T> focusAreasRefs<T extends Object>(
      Expression<T> Function($$FocusAreasTableAnnotationComposer a) f) {
    final $$FocusAreasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.focusAreas,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FocusAreasTableAnnotationComposer(
              $db: $db,
              $table: $db.focusAreas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfileData,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (UserProfileData, $$UserProfilesTableReferences),
    UserProfileData,
    PrefetchHooks Function({bool focusAreasRefs})> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> passwordHash = const Value.absent(),
            Value<String?> salt = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            name: name,
            level: level,
            email: email,
            passwordHash: passwordHash,
            salt: salt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> level = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> passwordHash = const Value.absent(),
            Value<String?> salt = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            name: name,
            level: level,
            email: email,
            passwordHash: passwordHash,
            salt: salt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserProfilesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({focusAreasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (focusAreasRefs) db.focusAreas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (focusAreasRefs)
                    await $_getPrefetchedData<UserProfileData,
                            $UserProfilesTable, FocusAreaData>(
                        currentTable: table,
                        referencedTable: $$UserProfilesTableReferences
                            ._focusAreasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserProfilesTableReferences(db, table, p0)
                                .focusAreasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfileData,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (UserProfileData, $$UserProfilesTableReferences),
    UserProfileData,
    PrefetchHooks Function({bool focusAreasRefs})>;
typedef $$FocusAreasTableCreateCompanionBuilder = FocusAreasCompanion Function({
  Value<int> id,
  required int userId,
  required String areaName,
});
typedef $$FocusAreasTableUpdateCompanionBuilder = FocusAreasCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> areaName,
});

final class $$FocusAreasTableReferences
    extends BaseReferences<_$AppDatabase, $FocusAreasTable, FocusAreaData> {
  $$FocusAreasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserProfilesTable _userIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias(
          $_aliasNameGenerator(db.focusAreas.userId, db.userProfiles.id));

  $$UserProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserProfilesTableTableManager($_db, $_db.userProfiles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FocusAreasTableFilterComposer
    extends Composer<_$AppDatabase, $FocusAreasTable> {
  $$FocusAreasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get areaName => $composableBuilder(
      column: $table.areaName, builder: (column) => ColumnFilters(column));

  $$UserProfilesTableFilterComposer get userId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfilesTableFilterComposer(
              $db: $db,
              $table: $db.userProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FocusAreasTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusAreasTable> {
  $$FocusAreasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get areaName => $composableBuilder(
      column: $table.areaName, builder: (column) => ColumnOrderings(column));

  $$UserProfilesTableOrderingComposer get userId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.userProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FocusAreasTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusAreasTable> {
  $$FocusAreasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get areaName =>
      $composableBuilder(column: $table.areaName, builder: (column) => column);

  $$UserProfilesTableAnnotationComposer get userId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.userProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FocusAreasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusAreasTable,
    FocusAreaData,
    $$FocusAreasTableFilterComposer,
    $$FocusAreasTableOrderingComposer,
    $$FocusAreasTableAnnotationComposer,
    $$FocusAreasTableCreateCompanionBuilder,
    $$FocusAreasTableUpdateCompanionBuilder,
    (FocusAreaData, $$FocusAreasTableReferences),
    FocusAreaData,
    PrefetchHooks Function({bool userId})> {
  $$FocusAreasTableTableManager(_$AppDatabase db, $FocusAreasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusAreasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusAreasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusAreasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> areaName = const Value.absent(),
          }) =>
              FocusAreasCompanion(
            id: id,
            userId: userId,
            areaName: areaName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String areaName,
          }) =>
              FocusAreasCompanion.insert(
            id: id,
            userId: userId,
            areaName: areaName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FocusAreasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$FocusAreasTableReferences._userIdTable(db),
                    referencedColumn:
                        $$FocusAreasTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FocusAreasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FocusAreasTable,
    FocusAreaData,
    $$FocusAreasTableFilterComposer,
    $$FocusAreasTableOrderingComposer,
    $$FocusAreasTableAnnotationComposer,
    $$FocusAreasTableCreateCompanionBuilder,
    $$FocusAreasTableUpdateCompanionBuilder,
    (FocusAreaData, $$FocusAreasTableReferences),
    FocusAreaData,
    PrefetchHooks Function({bool userId})>;
typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  required DateTime date,
  required int durationSeconds,
  required int streakDay,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> durationSeconds,
  Value<int> streakDay,
});

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, SessionData> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionStretchesTable, List<SessionStretchData>>
      _sessionStretchesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.sessionStretches,
              aliasName: $_aliasNameGenerator(
                  db.sessions.id, db.sessionStretches.sessionId));

  $$SessionStretchesTableProcessedTableManager get sessionStretchesRefs {
    final manager =
        $$SessionStretchesTableTableManager($_db, $_db.sessionStretches)
            .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_sessionStretchesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDay => $composableBuilder(
      column: $table.streakDay, builder: (column) => ColumnFilters(column));

  Expression<bool> sessionStretchesRefs(
      Expression<bool> Function($$SessionStretchesTableFilterComposer f) f) {
    final $$SessionStretchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessionStretches,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionStretchesTableFilterComposer(
              $db: $db,
              $table: $db.sessionStretches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDay => $composableBuilder(
      column: $table.streakDay, builder: (column) => ColumnOrderings(column));
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<int> get streakDay =>
      $composableBuilder(column: $table.streakDay, builder: (column) => column);

  Expression<T> sessionStretchesRefs<T extends Object>(
      Expression<T> Function($$SessionStretchesTableAnnotationComposer a) f) {
    final $$SessionStretchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessionStretches,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionStretchesTableAnnotationComposer(
              $db: $db,
              $table: $db.sessionStretches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    SessionData,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (SessionData, $$SessionsTableReferences),
    SessionData,
    PrefetchHooks Function({bool sessionStretchesRefs})> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<int> streakDay = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            date: date,
            durationSeconds: durationSeconds,
            streakDay: streakDay,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int durationSeconds,
            required int streakDay,
          }) =>
              SessionsCompanion.insert(
            id: id,
            date: date,
            durationSeconds: durationSeconds,
            streakDay: streakDay,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SessionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({sessionStretchesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sessionStretchesRefs) db.sessionStretches
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionStretchesRefs)
                    await $_getPrefetchedData<SessionData, $SessionsTable,
                            SessionStretchData>(
                        currentTable: table,
                        referencedTable: $$SessionsTableReferences
                            ._sessionStretchesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SessionsTableReferences(db, table, p0)
                                .sessionStretchesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionsTable,
    SessionData,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (SessionData, $$SessionsTableReferences),
    SessionData,
    PrefetchHooks Function({bool sessionStretchesRefs})>;
typedef $$SessionStretchesTableCreateCompanionBuilder
    = SessionStretchesCompanion Function({
  Value<int> id,
  required int sessionId,
  required String stretchName,
  required int durationSeconds,
  Value<String?> feedback,
});
typedef $$SessionStretchesTableUpdateCompanionBuilder
    = SessionStretchesCompanion Function({
  Value<int> id,
  Value<int> sessionId,
  Value<String> stretchName,
  Value<int> durationSeconds,
  Value<String?> feedback,
});

final class $$SessionStretchesTableReferences extends BaseReferences<
    _$AppDatabase, $SessionStretchesTable, SessionStretchData> {
  $$SessionStretchesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
          $_aliasNameGenerator(db.sessionStretches.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SessionStretchesTableFilterComposer
    extends Composer<_$AppDatabase, $SessionStretchesTable> {
  $$SessionStretchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stretchName => $composableBuilder(
      column: $table.stretchName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedback => $composableBuilder(
      column: $table.feedback, builder: (column) => ColumnFilters(column));

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SessionStretchesTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionStretchesTable> {
  $$SessionStretchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stretchName => $composableBuilder(
      column: $table.stretchName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedback => $composableBuilder(
      column: $table.feedback, builder: (column) => ColumnOrderings(column));

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableOrderingComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SessionStretchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionStretchesTable> {
  $$SessionStretchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get stretchName => $composableBuilder(
      column: $table.stretchName, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SessionStretchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionStretchesTable,
    SessionStretchData,
    $$SessionStretchesTableFilterComposer,
    $$SessionStretchesTableOrderingComposer,
    $$SessionStretchesTableAnnotationComposer,
    $$SessionStretchesTableCreateCompanionBuilder,
    $$SessionStretchesTableUpdateCompanionBuilder,
    (SessionStretchData, $$SessionStretchesTableReferences),
    SessionStretchData,
    PrefetchHooks Function({bool sessionId})> {
  $$SessionStretchesTableTableManager(
      _$AppDatabase db, $SessionStretchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionStretchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionStretchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionStretchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sessionId = const Value.absent(),
            Value<String> stretchName = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<String?> feedback = const Value.absent(),
          }) =>
              SessionStretchesCompanion(
            id: id,
            sessionId: sessionId,
            stretchName: stretchName,
            durationSeconds: durationSeconds,
            feedback: feedback,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sessionId,
            required String stretchName,
            required int durationSeconds,
            Value<String?> feedback = const Value.absent(),
          }) =>
              SessionStretchesCompanion.insert(
            id: id,
            sessionId: sessionId,
            stretchName: stretchName,
            durationSeconds: durationSeconds,
            feedback: feedback,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SessionStretchesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$SessionStretchesTableReferences._sessionIdTable(db),
                    referencedColumn: $$SessionStretchesTableReferences
                        ._sessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SessionStretchesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionStretchesTable,
    SessionStretchData,
    $$SessionStretchesTableFilterComposer,
    $$SessionStretchesTableOrderingComposer,
    $$SessionStretchesTableAnnotationComposer,
    $$SessionStretchesTableCreateCompanionBuilder,
    $$SessionStretchesTableUpdateCompanionBuilder,
    (SessionStretchData, $$SessionStretchesTableReferences),
    SessionStretchData,
    PrefetchHooks Function({bool sessionId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$FocusAreasTableTableManager get focusAreas =>
      $$FocusAreasTableTableManager(_db, _db.focusAreas);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SessionStretchesTableTableManager get sessionStretches =>
      $$SessionStretchesTableTableManager(_db, _db.sessionStretches);
}
