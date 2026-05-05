import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database/app_database.dart';
import '../data/repositories/drift_session_repository.dart';
import '../data/repositories/drift_user_repository.dart';
import '../data/repositories/shared_prefs_settings_repository.dart';
import '../domain/models/session_record.dart';
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

// ── Repositories (concrete, implement both Q and C interfaces) ────────────────

final _sessionRepoProvider = Provider<DriftSessionRepository>(
  (ref) => DriftSessionRepository(ref.watch(databaseProvider)),
);

final _userRepoProvider = Provider<DriftUserRepository>(
  (ref) => DriftUserRepository(ref.watch(databaseProvider)),
);

final _settingsRepoProvider = Provider<SharedPrefsSettingsRepository>(
  (ref) => SharedPrefsSettingsRepository(ref.watch(sharedPreferencesProvider)),
);

// ── CQRS — expose only the interface the caller needs ────────────────────────

final sessionQueriesProvider = Provider<ISessionQueries>(
  (ref) => ref.watch(_sessionRepoProvider),
);

final sessionCommandsProvider = Provider<ISessionCommands>(
  (ref) => ref.watch(_sessionRepoProvider),
);

final userQueriesProvider = Provider<IUserQueries>(
  (ref) => ref.watch(_userRepoProvider),
);

final userCommandsProvider = Provider<IUserCommands>(
  (ref) => ref.watch(_userRepoProvider),
);

final settingsQueriesProvider = Provider<ISettingsQueries>(
  (ref) => ref.watch(_settingsRepoProvider),
);

final settingsCommandsProvider = Provider<ISettingsCommands>(
  (ref) => ref.watch(_settingsRepoProvider),
);

// ── UI state providers ────────────────────────────────────────────────────────

final lastSessionProvider = FutureProvider<SessionRecord?>((ref) {
  return ref.watch(sessionQueriesProvider).getLastSession();
});

final currentStreakProvider = FutureProvider<int>((ref) {
  return ref.watch(sessionQueriesProvider).getCurrentStreak();
});
