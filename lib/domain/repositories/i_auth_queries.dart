abstract interface class IAuthQueries {
  /// Returns the user id if credentials are valid, null otherwise.
  Future<int?> authenticate({required String email, required String password});
  Future<bool> isEmailTaken(String email);
}
