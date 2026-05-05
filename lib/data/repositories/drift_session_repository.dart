import 'package:drift/drift.dart';
import '../../domain/models/session_record.dart';
import '../../domain/repositories/i_session_commands.dart';
import '../../domain/repositories/i_session_queries.dart';
import '../database/app_database.dart';

class DriftSessionRepository implements ISessionQueries, ISessionCommands {
  final AppDatabase _db;

  DriftSessionRepository(this._db);

  // ── Queries ──────────────────────────────────────────────────────────────

  @override
  Future<List<SessionRecord>> getHistory({int limit = 20}) async {
    final rows = await (_db.select(_db.sessions)
          ..orderBy([(s) => OrderingTerm.desc(s.date)])
          ..limit(limit))
        .get();

    return Future.wait(rows.map(_toRecord));
  }

  @override
  Future<SessionRecord?> getLastSession() async {
    final rows = await (_db.select(_db.sessions)
          ..orderBy([(s) => OrderingTerm.desc(s.date)])
          ..limit(1))
        .get();

    if (rows.isEmpty) return null;
    return _toRecord(rows.first);
  }

  @override
  Future<int> getCurrentStreak() async {
    final last = await getLastSession();
    if (last == null) return 0;

    final today = DateTime.now();
    final diff = today.difference(last.date).inDays;

    // Streak is still alive if last session was today or yesterday
    return diff <= 1 ? last.streakDay : 0;
  }

  // ── Commands ─────────────────────────────────────────────────────────────

  @override
  Future<void> saveSession(SessionRecord session) async {
    final sessionId = await _db.into(_db.sessions).insert(
          SessionsCompanion.insert(
            date: session.date,
            durationSeconds: session.durationSeconds,
            streakDay: session.streakDay,
          ),
        );

    for (final stretch in session.stretches) {
      await _db.into(_db.sessionStretches).insert(
            SessionStretchesCompanion.insert(
              sessionId: sessionId,
              stretchName: stretch.name,
              durationSeconds: stretch.durationSeconds,
              feedback: Value(stretch.feedback),
            ),
          );
    }
  }

  @override
  Future<void> deleteSession(int id) async {
    await (_db.delete(_db.sessionStretches)
          ..where((s) => s.sessionId.equals(id)))
        .go();
    await (_db.delete(_db.sessions)..where((s) => s.id.equals(id))).go();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Future<SessionRecord> _toRecord(SessionData row) async {
    final stretches = await (_db.select(_db.sessionStretches)
          ..where((s) => s.sessionId.equals(row.id)))
        .get();

    return SessionRecord(
      id: row.id,
      date: row.date,
      durationSeconds: row.durationSeconds,
      streakDay: row.streakDay,
      stretches: stretches
          .map((s) => StretchRecord(
                name: s.stretchName,
                durationSeconds: s.durationSeconds,
                feedback: s.feedback,
              ))
          .toList(),
    );
  }
}
