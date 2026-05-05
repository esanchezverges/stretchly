import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/repositories/i_settings_commands.dart';
import '../../domain/repositories/i_settings_queries.dart';

class SharedPrefsSettingsRepository
    implements ISettingsQueries, ISettingsCommands {
  final SharedPreferences _prefs;

  SharedPrefsSettingsRepository(this._prefs);

  static const _kDuration = 'pref_duration';
  static const _kIntensity = 'pref_intensity';
  static const _kDailyReminder = 'notif_daily';
  static const _kStreakProtection = 'notif_streak';
  static const _kPostWorkout = 'notif_post_workout';

  // ── Queries ───────────────────────────────────────────────────────────────

  @override
  Future<AppSettings> getSettings() async => AppSettings(
        durationMinutes: _prefs.getInt(_kDuration) ?? 10,
        intensity: _prefs.getString(_kIntensity) ?? 'moderate',
        dailyReminder: _prefs.getBool(_kDailyReminder) ?? true,
        streakProtection: _prefs.getBool(_kStreakProtection) ?? true,
        postWorkoutPrompt: _prefs.getBool(_kPostWorkout) ?? false,
      );

  // ── Commands ──────────────────────────────────────────────────────────────

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _prefs.setInt(_kDuration, settings.durationMinutes);
    await _prefs.setString(_kIntensity, settings.intensity);
    await _prefs.setBool(_kDailyReminder, settings.dailyReminder);
    await _prefs.setBool(_kStreakProtection, settings.streakProtection);
    await _prefs.setBool(_kPostWorkout, settings.postWorkoutPrompt);
  }
}
