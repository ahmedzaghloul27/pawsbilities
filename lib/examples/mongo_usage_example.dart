import '../services/mongo_service.dart';
import '../models/user_model.dart';
import '../models/pet_model.dart';

/// Example usage of MongoDB service for Pawsbilities app
class MongoUsageExample {
  /// Example: Create a new user
  static Future<void> createUserExample() async {
    final userData = {
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john.doe@example.com',
      'bio': 'Dog lover and rescue advocate',
      'location': 'New York, NY',
      'isOnline': true,
    };

    final userId = await MongoService.createUser(userData);
    if (userId != null) {
      print('✅ User created with ID: $userId');
    } else {
      print('❌ Failed to create user');
    }
  }

  /// Example: Create a new pet
  static Future<void> createPetExample(String ownerId) async {
    final petData = {
      'name': 'Buddy',
      'breed': 'Golden Retriever',
      'age': '3 years',
      'weight': '30 kg',
      'isFemale': false,
      'ownerId': ownerId,
      'imageUrl': 'assets/images/dog.png',
      'additionalImages': ['assets/images/dog2.jpg', 'assets/images/dog3.jpg'],
      'personality': 'Friendly, Energetic, Loyal',
      'description': 'Buddy loves playing fetch and swimming!',
      'isAvailable': true,
    };

    final petId = await MongoService.createPet(petData);
    if (petId != null) {
      print('✅ Pet created with ID: $petId');
    } else {
      print('❌ Failed to create pet');
    }
  }

  /// Example: Get available pets for matching
  static Future<void> getAvailablePetsExample() async {
    final pets = await MongoService.getAvailablePets();
    print('📱 Found ${pets.length} available pets');

    for (final pet in pets) {
      final petModel = Pet.fromMap(pet);
      print('🐕 ${petModel.name} - ${petModel.breed}');
    }
  }

  /// Example: Create a match between users
  static Future<void> createMatchExample(
      String userId1, String userId2, String petId) async {
    final matchId = await MongoService.createMatch(userId1, userId2, petId);
    if (matchId != null) {
      print('✅ Match created with ID: $matchId');
    } else {
      print('❌ Failed to create match');
    }
  }

  /// Example: Send a message
  static Future<void> sendMessageExample(
      String chatId, String senderId, String content) async {
    final messageData = {
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'type': 'text',
      'isRead': false,
    };

    final messageId = await MongoService.sendMessage(messageData);
    if (messageId != null) {
      print('✅ Message sent with ID: $messageId');
    } else {
      print('❌ Failed to send message');
    }
  }

  /// Example: Create a community post
  static Future<void> createPostExample(String userId) async {
    final postData = {
      'userId': userId,
      'content': 'Just adopted this beautiful golden retriever! 🐕❤️',
      'imageUrl': 'assets/images/dog.png',
      'location': 'New York, NY',
      'tags': ['adoption', 'golden-retriever', 'happy'],
    };

    final postId = await MongoService.createPost(postData);
    if (postId != null) {
      print('✅ Post created with ID: $postId');
    } else {
      print('❌ Failed to create post');
    }
  }

  /// Example: Create lost & found post
  static Future<void> createLostFoundExample(String userId) async {
    final lostFoundData = {
      'userId': userId,
      'type': 'lost', // 'lost' or 'found'
      'petName': 'Max',
      'breed': 'Border Collie',
      'description': 'Lost near Central Park, wearing a blue collar',
      'imageUrl': 'assets/images/dog2.jpg',
      'location': 'Central Park, NY',
      'contactInfo': 'Call: (555) 123-4567',
      'reward': 100,
    };

    final postId = await MongoService.createLostFoundPost(lostFoundData);
    if (postId != null) {
      print('✅ Lost & Found post created with ID: $postId');
    } else {
      print('❌ Failed to create Lost & Found post');
    }
  }

  /// Run all examples
  static Future<void> runAllExamples() async {
    print('🚀 Running MongoDB examples for Pawsbilities...\n');

    // Create user
    await createUserExample();

    // Get a user (simulate getting the created user)
    final users = await MongoService.users.find().toList();
    if (users.isNotEmpty) {
      final userId = users.first['_id'].toString();

      // Create pet for this user
      await createPetExample(userId);

      // Get available pets
      await getAvailablePetsExample();

      // Create community post
      await createPostExample(userId);

      // Create lost & found post
      await createLostFoundExample(userId);

      // Send message example
      await sendMessageExample(
          'chat_123', userId, 'Hello! Is your pet still available?');
    }

    print('\n✅ All examples completed!');
  }
}
