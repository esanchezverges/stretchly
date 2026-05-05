import '../models/app_settings.dart';

abstract interface class ISettingsCommands {
  Future<void> saveSettings(AppSettings settings);
}
