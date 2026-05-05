import '../models/session_record.dart';

abstract interface class ISessionQueries {
  Future<List<SessionRecord>> getHistory({int limit = 20});
  Future<SessionRecord?> getLastSession();
  Future<int> getCurrentStreak();
}
