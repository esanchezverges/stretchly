import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../../domain/repositories/i_auth_commands.dart';
import '../../domain/repositories/i_auth_queries.dart';
import '../database/app_database.dart';

class DriftAuthRepository implements IAuthQueries, IAuthCommands {
  final AppDatabase _db;

  DriftAuthRepository(this._db);

  // ── Queries ───────────────────────────────────────────────────────────────

  @override
  Future<int?> authenticate({
    required String email,
    required String password,
  }) async {
    final row = await (_db.select(_db.userProfiles)
          ..where((u) => u.email.equals(email)))
        .getSingleOrNull();

    if (row == null || row.passwordHash == null || row.salt == null) return null;

    final hash = _hash(password, row.salt!);
    return hash == row.passwordHash ? row.id : null;
  }

  @override
  Future<bool> isEmailTaken(String email) async {
    final row = await (_db.select(_db.userProfiles)
          ..where((u) => u.email.equals(email)))
        .getSingleOrNull();
    return row != null;
  }

  // ── Commands ──────────────────────────────────────────────────────────────

  @override
  Future<int> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final salt = DateTime.now().microsecondsSinceEpoch.toString();
    final hash = _hash(password, salt);

    return _db.into(_db.userProfiles).insert(
          UserProfilesCompanion.insert(
            name: name,
            email: Value(email),
            passwordHash: Value(hash),
            salt: Value(salt),
          ),
        );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _hash(String password, String salt) {
    final bytes = utf8.encode('$password$salt');
    return sha256.convert(bytes).toString();
  }
}
