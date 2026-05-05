import 'package:drift/drift.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/repositories/i_user_commands.dart';
import '../../domain/repositories/i_user_queries.dart';
import '../database/app_database.dart';

class DriftUserRepository implements IUserQueries, IUserCommands {
  final AppDatabase _db;

  DriftUserRepository(this._db);

  // ── Queries ───────────────────────────────────────────────────────────────

  @override
  Future<UserProfile?> getProfile() async {
    final row = await (_db.select(_db.userProfiles)..limit(1)).getSingleOrNull();
    if (row == null) return null;

    final areas = await (_db.select(_db.focusAreas)
          ..where((a) => a.userId.equals(row.id)))
        .get();

    return UserProfile(
      id: row.id,
      name: row.name,
      level: row.level,
      focusAreas: areas.map((a) => a.areaName).toList(),
    );
  }

  // ── Commands ──────────────────────────────────────────────────────────────

  @override
  Future<void> saveProfile(UserProfile profile) async {
    int userId;

    if (profile.id != null) {
      await (_db.update(_db.userProfiles)
            ..where((u) => u.id.equals(profile.id!)))
          .write(UserProfilesCompanion(
            name: Value(profile.name),
            level: Value(profile.level),
          ));
      userId = profile.id!;
    } else {
      userId = await _db.into(_db.userProfiles).insert(
            UserProfilesCompanion.insert(
              name: profile.name,
              level: Value(profile.level),
            ),
          );
    }

    // Replace focus areas
    await (_db.delete(_db.focusAreas)
          ..where((a) => a.userId.equals(userId)))
        .go();

    for (final area in profile.focusAreas) {
      await _db.into(_db.focusAreas).insert(
            FocusAreasCompanion.insert(userId: userId, areaName: area),
          );
    }
  }
}
