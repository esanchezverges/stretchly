import '../models/session_record.dart';

abstract interface class ISessionCommands {
  Future<void> saveSession(SessionRecord session);
  Future<void> deleteSession(int id);
}
