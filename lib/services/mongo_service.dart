import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import '../config/database_config.dart';

class MongoService {
  static Db? _db;

  // Collection getters
  static DbCollection get users =>
      _db!.collection(DatabaseConfig.usersCollection);
  static DbCollection get pets =>
      _db!.collection(DatabaseConfig.petsCollection);
  static DbCollection get matches =>
      _db!.collection(DatabaseConfig.matchesCollection);
  static DbCollection get messages =>
      _db!.collection(DatabaseConfig.messagesCollection);
  static DbCollection get posts =>
      _db!.collection(DatabaseConfig.postsCollection);
  static DbCollection get lostFound =>
      _db!.collection(DatabaseConfig.lostFoundCollection);

  /// Connect to MongoDB database
  static Future<void> connect() async {
    try {
      _db = await Db.create(DatabaseConfig.mongoUri);
      await _db!.open();
      log('✅ Successfully connected to MongoDB');
      inspect(_db);
    } catch (e) {
      log('❌ Failed to connect to MongoDB: ${e.toString()}');
      rethrow;
    }
  }

  /// Close MongoDB connection
  static Future<void> close() async {
    try {
      if (_db != null) {
        await _db!.close();
        log('✅ MongoDB connection closed');
      }
    } catch (e) {
      log('❌ Error closing MongoDB connection: ${e.toString()}');
    }
  }

  /// Check if database is connected
  static bool get isConnected => _db != null && _db!.isConnected;

  // User operations
  static Future<Map<String, dynamic>?> getUserById(String userId) async {
    try {
      final query = where.eq('_id', ObjectId.parse(userId));
      return await users.findOne(query);
    } catch (e) {
      log('Error getting user: ${e.toString()}');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final query = where.eq('email', email);
      return await users.findOne(query);
    } catch (e) {
      log('Error getting user by email: ${e.toString()}');
      return null;
    }
  }

  static Future<String?> createUser(Map<String, dynamic> userData) async {
    try {
      userData['createdAt'] = DateTime.now();
      userData['updatedAt'] = DateTime.now();
      final result = await users.insertOne(userData);
      return result.id.toString();
    } catch (e) {
      log('Error creating user: ${e.toString()}');
      return null;
    }
  }

  static Future<bool> updateUser(
      String userId, Map<String, dynamic> updates) async {
    try {
      updates['updatedAt'] = DateTime.now();
      final query = where.eq('_id', ObjectId.parse(userId));
      final result =
          await users.updateOne(query, modify.set('updates', updates));
      return result.isSuccess;
    } catch (e) {
      log('Error updating user: ${e.toString()}');
      return false;
    }
  }

  // Pet operations
  static Future<List<Map<String, dynamic>>> getPetsByUserId(
      String userId) async {
    try {
      final query = where.eq('ownerId', userId);
      return await pets.find(query).toList();
    } catch (e) {
      log('Error getting pets: ${e.toString()}');
      return [];
    }
  }

  static Future<String?> createPet(Map<String, dynamic> petData) async {
    try {
      petData['createdAt'] = DateTime.now();
      petData['updatedAt'] = DateTime.now();
      final result = await pets.insertOne(petData);
      return result.id.toString();
    } catch (e) {
      log('Error creating pet: ${e.toString()}');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getAvailablePets({
    String? breed,
    int? minAge,
    int? maxAge,
    double? maxDistance,
  }) async {
    try {
      var query = where.eq('isAvailable', true);

      if (breed != null) {
        query = query.and(where.eq('breed', breed));
      }

      return await pets.find(query).toList();
    } catch (e) {
      log('Error getting available pets: ${e.toString()}');
      return [];
    }
  }

  // Match operations
  static Future<String?> createMatch(
      String userId1, String userId2, String petId) async {
    try {
      final matchData = {
        'user1Id': userId1,
        'user2Id': userId2,
        'petId': petId,
        'status': 'pending', // pending, accepted, rejected
        'createdAt': DateTime.now(),
      };
      final result = await matches.insertOne(matchData);
      return result.id.toString();
    } catch (e) {
      log('Error creating match: ${e.toString()}');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getUserMatches(
      String userId) async {
    try {
      final query = where.eq('user1Id', userId).or(where.eq('user2Id', userId));
      return await matches.find(query).toList();
    } catch (e) {
      log('Error getting matches: ${e.toString()}');
      return [];
    }
  }

  // Message operations
  static Future<String?> sendMessage(Map<String, dynamic> messageData) async {
    try {
      messageData['timestamp'] = DateTime.now();
      final result = await messages.insertOne(messageData);
      return result.id.toString();
    } catch (e) {
      log('Error sending message: ${e.toString()}');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getChatMessages(
      String chatId) async {
    try {
      final query = where.eq('chatId', chatId).sortBy('timestamp');
      return await messages.find(query).toList();
    } catch (e) {
      log('Error getting messages: ${e.toString()}');
      return [];
    }
  }

  // Post operations (for community feature)
  static Future<String?> createPost(Map<String, dynamic> postData) async {
    try {
      postData['createdAt'] = DateTime.now();
      postData['likes'] = 0;
      postData['comments'] = [];
      final result = await posts.insertOne(postData);
      return result.id.toString();
    } catch (e) {
      log('Error creating post: ${e.toString()}');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getCommunityPosts(
      {int limit = 20}) async {
    try {
      return await posts.find().take(limit).toList();
    } catch (e) {
      log('Error getting posts: ${e.toString()}');
      return [];
    }
  }

  // Lost & Found operations
  static Future<String?> createLostFoundPost(
      Map<String, dynamic> postData) async {
    try {
      postData['createdAt'] = DateTime.now();
      postData['status'] = 'active'; // active, resolved
      final result = await lostFound.insertOne(postData);
      return result.id.toString();
    } catch (e) {
      log('Error creating lost/found post: ${e.toString()}');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getLostFoundPosts() async {
    try {
      final query =
          where.eq('status', 'active').sortBy('createdAt', descending: true);
      return await lostFound.find(query).toList();
    } catch (e) {
      log('Error getting lost/found posts: ${e.toString()}');
      return [];
    }
  }
}
