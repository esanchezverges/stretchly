import '../models/app_settings.dart';

abstract interface class ISettingsQueries {
  Future<AppSettings> getSettings();
}
