// MongoDB Configuration for Pawsbilities App
class DatabaseConfig {
  // MongoDB Atlas connection string
  static const String mongoUri =
      'mongodb+srv://adhamt79:N9eUSfzthq1gT7bG@adhamcluster.2zfyf.mongodb.net/pawsbilities';

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
