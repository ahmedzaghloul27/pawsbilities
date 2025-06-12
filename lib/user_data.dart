import 'dart:io';
import 'services/auth_manager.dart';

class UserData {
  // Get user data from AuthManager instead of hardcoded values
  static String get firstName => AuthManager().currentUser?.firstName ?? 'User';
  static String get lastName => AuthManager().currentUser?.lastName ?? '';
  static String get email => AuthManager().currentUser?.email ?? '';
  static String get bio =>
      AuthManager().currentUser?.bio ?? 'Welcome to Pawsibilities!';
  static String get fullName => AuthManager().userFullName;
  static String? get location => AuthManager().currentUser?.location;

  // Profile image handling - for now keeping local file capability
  static File? _profileImage;
  static File? get profileImage => _profileImage;

  // Update local profile image
  static void updateProfileImage(File? profileImage) {
    _profileImage = profileImage;
  }

  // Update profile method that uses AuthManager
  static Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? bio,
    String? location,
    File? profileImage,
    String? profileImageUrl,
  }) async {
    final authManager = AuthManager();

    if (!authManager.isAuthenticated) {
      return false;
    }

    // Update local profile image
    if (profileImage != null) {
      _profileImage = profileImage;
    }

    // Prepare data for API
    final updateData = <String, dynamic>{};
    if (firstName != null) updateData['firstName'] = firstName;
    if (lastName != null) updateData['lastName'] = lastName;
    if (email != null) updateData['email'] = email;
    if (bio != null) updateData['bio'] = bio;
    if (location != null) updateData['location'] = location;
    if (profileImageUrl != null)
      updateData['profileImageUrl'] = profileImageUrl;

    // Update via AuthManager which handles API calls
    if (updateData.isNotEmpty) {
      return await authManager.updateProfile(updateData);
    }

    return true;
  }

  // Check if user is authenticated
  static bool get isAuthenticated => AuthManager().isAuthenticated;

  // Get user ID
  static String? get userId => AuthManager().userId;
}
