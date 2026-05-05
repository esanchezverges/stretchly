import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ── Tables ────────────────────────────────────────────────────────────────────

@DataClassName('UserProfileData')
class UserProfiles extends Table {
  IntColumn get id       => integer().autoIncrement()();
  TextColumn get name    => text()();
  TextColumn get level   => text().withDefault(const Constant('beginner'))();
  // Auth columns (nullable so existing rows survive migration)
  TextColumn get email        => text().nullable()();
  TextColumn get passwordHash => text().nullable()();
  TextColumn get salt         => text().nullable()();
}

@DataClassName('FocusAreaData')
class FocusAreas extends Table {
  IntColumn get id       => integer().autoIncrement()();
  IntColumn get userId   => integer().references(UserProfiles, #id)();
  TextColumn get areaName => text()();
}

@DataClassName('SessionData')
class Sessions extends Table {
  IntColumn get id               => integer().autoIncrement()();
  DateTimeColumn get date        => dateTime()();
  IntColumn get durationSeconds  => integer()();
  IntColumn get streakDay        => integer()();
}

@DataClassName('SessionStretchData')
class SessionStretches extends Table {
  IntColumn get id              => integer().autoIncrement()();
  IntColumn get sessionId       => integer().references(Sessions, #id)();
  TextColumn get stretchName    => text()();
  IntColumn get durationSeconds => integer()();
  TextColumn get feedback       => text().nullable()();
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [UserProfiles, FocusAreas, Sessions, SessionStretches])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(userProfiles, userProfiles.email);
            await m.addColumn(userProfiles, userProfiles.passwordHash);
            await m.addColumn(userProfiles, userProfiles.salt);
          }
          // Future migrations:
          // if (from < 3) { ... }
        },
      );

  static QueryExecutor _openConnection() => driftDatabase(name: 'stretchly');
}
