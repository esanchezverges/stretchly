abstract interface class IAuthCommands {
  /// Creates a new user and returns their id.
  Future<int> register({
    required String name,
    required String email,
    required String password,
  });
}
