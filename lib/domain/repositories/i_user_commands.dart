import '../models/user_profile.dart';

abstract interface class IUserCommands {
  Future<void> saveProfile(UserProfile profile);
}
