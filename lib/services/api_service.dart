import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/pet_model.dart';

class ApiService {
  // Update this URL when you deploy your backend or run it locally
  static const String baseUrl = 'http://localhost:3000/api';

  // Headers for API requests
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Auth headers with token
  static Map<String, String> authHeaders(String token) => {
        ...headers,
        'Authorization': 'Bearer $token',
      };

  /// User Authentication
  static Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
    String? location,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: headers,
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'phone': phone,
          'location': location,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Registration failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Login failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  /// User Profile Operations
  static Future<Map<String, dynamic>?> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/profile'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Get profile error: $e');
      return null;
    }
  }

  static Future<bool> updateUserProfile(
    String token,
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/profile'),
        headers: authHeaders(token),
        body: jsonEncode(userData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }

  /// Pet Operations
  static Future<List<Map<String, dynamic>>> getPets(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pets'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['pets'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get pets error: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>?> createPet(
    String token,
    Map<String, dynamic> petData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pets'),
        headers: authHeaders(token),
        body: jsonEncode(petData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Create pet error: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getAvailablePetsForAdoption(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pets/available'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['pets'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get available pets error: $e');
      return [];
    }
  }

  /// Match Operations
  static Future<bool> createMatch(
    String token,
    String petId,
    String adopterId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/matches'),
        headers: authHeaders(token),
        body: jsonEncode({
          'petId': petId,
          'adopterId': adopterId,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Create match error: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getMatches(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/matches'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['matches'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get matches error: $e');
      return [];
    }
  }

  /// Message Operations
  static Future<bool> sendMessage(
      String token, String receiverId, String content,
      {String type = 'text'}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages'),
        headers: authHeaders(token),
        body: jsonEncode({
          'receiverId': receiverId,
          'content': content,
          'type': type,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Send message error: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getChatMessages(
    String token,
    String chatId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/messages/$chatId'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['messages'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get messages error: $e');
      return [];
    }
  }

  /// Community Posts
  static Future<List<Map<String, dynamic>>> getCommunityPosts(
      String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['posts'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get posts error: $e');
      return [];
    }
  }

  static Future<bool> createPost(
    String token,
    Map<String, dynamic> postData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: authHeaders(token),
        body: jsonEncode(postData),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Create post error: $e');
      return false;
    }
  }

  /// Lost & Found Posts
  static Future<List<Map<String, dynamic>>> getLostFoundPosts(
      String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/lost-found'),
        headers: authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['posts'] ?? []);
      }
      return [];
    } catch (e) {
      print('Get lost/found posts error: $e');
      return [];
    }
  }

  static Future<bool> createLostFoundPost(
    String token,
    Map<String, dynamic> postData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/lost-found'),
        headers: authHeaders(token),
        body: jsonEncode(postData),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Create lost/found post error: $e');
      return false;
    }
  }

  /// File Upload
  static Future<String?> uploadImage(String token, File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload'),
      );

      request.headers.addAll(authHeaders(token));
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        return data['imageUrl'];
      }
      return null;
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }
}
