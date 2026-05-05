import '../models/user_profile.dart';

abstract interface class IUserQueries {
  Future<UserProfile?> getProfile();
}
