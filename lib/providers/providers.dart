import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database/app_database.dart';
import '../data/repositories/drift_auth_repository.dart';
import '../data/repositories/drift_session_repository.dart';
import '../data/repositories/drift_user_repository.dart';
import '../data/repositories/shared_prefs_settings_repository.dart';
import '../domain/models/session_record.dart';
import '../domain/models/user_profile.dart';
import '../domain/repositories/i_auth_commands.dart';
import '../domain/repositories/i_auth_queries.dart';
import '../domain/repositories/i_session_commands.dart';
import '../domain/repositories/i_session_queries.dart';
import '../domain/repositories/i_settings_commands.dart';
import '../domain/repositories/i_settings_queries.dart';
import '../domain/repositories/i_user_commands.dart';
import '../domain/repositories/i_user_queries.dart';

// ── Infrastructure ────────────────────────────────────────────────────────────

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Overridden in main() after SharedPreferences.getInstance()
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

// ── Repositories ──────────────────────────────────────────────────────────────

final _sessionRepoProvider = Provider<DriftSessionRepository>(
  (ref) => DriftSessionRepository(ref.watch(databaseProvider)),
);

final _userRepoProvider = Provider<DriftUserRepository>(
  (ref) => DriftUserRepository(ref.watch(databaseProvider)),
);

final _settingsRepoProvider = Provider<SharedPrefsSettingsRepository>(
  (ref) => SharedPrefsSettingsRepository(ref.watch(sharedPreferencesProvider)),
);

final _authRepoProvider = Provider<DriftAuthRepository>(
  (ref) => DriftAuthRepository(ref.watch(databaseProvider)),
);

// ── CQRS interfaces ───────────────────────────────────────────────────────────

final sessionQueriesProvider =
    Provider<ISessionQueries>((ref) => ref.watch(_sessionRepoProvider));

final sessionCommandsProvider =
    Provider<ISessionCommands>((ref) => ref.watch(_sessionRepoProvider));

final userQueriesProvider =
    Provider<IUserQueries>((ref) => ref.watch(_userRepoProvider));

final userCommandsProvider =
    Provider<IUserCommands>((ref) => ref.watch(_userRepoProvider));

final settingsQueriesProvider =
    Provider<ISettingsQueries>((ref) => ref.watch(_settingsRepoProvider));

final settingsCommandsProvider =
    Provider<ISettingsCommands>((ref) => ref.watch(_settingsRepoProvider));

final authQueriesProvider =
    Provider<IAuthQueries>((ref) => ref.watch(_authRepoProvider));

final authCommandsProvider =
    Provider<IAuthCommands>((ref) => ref.watch(_authRepoProvider));

// ── Auth state ────────────────────────────────────────────────────────────────

const _kUserId = 'auth_user_id';

/// Null = not logged in. Persisted in SharedPreferences.
final currentUserIdProvider = StateProvider<int?>((ref) {
  return ref.read(sharedPreferencesProvider).getInt(_kUserId);
});

// ── UI state providers ────────────────────────────────────────────────────────

final lastSessionProvider = FutureProvider<SessionRecord?>((ref) {
  return ref.watch(sessionQueriesProvider).getLastSession();
});

final currentStreakProvider = FutureProvider<int>((ref) {
  return ref.watch(sessionQueriesProvider).getCurrentStreak();
});

final sessionCountProvider = FutureProvider<int>((ref) {
  return ref.watch(sessionQueriesProvider).getSessionCount();
});

final currentUserProfileProvider = FutureProvider<UserProfile?>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Future.value(null);
  return ref.watch(userQueriesProvider).getProfile();
});
