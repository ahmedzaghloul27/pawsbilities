import 'dart:io';

class UserData {
  static String _firstName = 'Mohammed';
  static String _lastName = 'Osama';
  static String _email = 'mohammed.osama@email.com';
  static String _bio =
      "I'm a software engineer and happy to be here on the app";
  static File? _profileImage;

  static String get firstName => _firstName;
  static String get lastName => _lastName;
  static String get email => _email;
  static String get bio => _bio;
  static String get fullName => '$_firstName $_lastName';
  static File? get profileImage => _profileImage;

  static void updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? bio,
    File? profileImage,
  }) {
    if (firstName != null) _firstName = firstName;
    if (lastName != null) _lastName = lastName;
    if (email != null) _email = email;
    if (bio != null) _bio = bio;
    if (profileImage != null) _profileImage = profileImage;
  }
}
