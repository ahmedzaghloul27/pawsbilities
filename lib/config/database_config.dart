import 'secure_config.dart';

// MongoDB Configuration for Pawsbilities App
class DatabaseConfig {
  // MongoDB Atlas connection string using secure configuration
  static String get mongoUri => SecureConfig.getMongoUri();

  // Collection names (matching the backend structure)
  static const String usersCollection = 'users';
  static const String petsCollection = 'pets';
  static const String matchesCollection = 'matches';
  static const String messagesCollection = 'messages';
  static const String postsCollection = 'posts';
  static const String lostFoundCollection = 'lost_found';
  static const String adoptersCollection = 'adopters';
  static const String organizationsCollection = 'organizations';
  static const String notificationsCollection = 'notifications';
}
