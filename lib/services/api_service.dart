import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/pet_model.dart';
import '../services/storage_service.dart';
import '../config/secure_config.dart';

/// Centralized API service for Pawsibilities Flutter app
class ApiService {
  /// Base URL loaded from SecureConfig (.env or default)
  static String get baseUrl => SecureConfig.getApiBaseUrl();

  /// Common headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Authenticated headers
  static Map<String, String> authHeaders(String token) => {
        ...headers,
        'Authorization': 'Bearer $token',
      };

  /// Try waking up the backend (handles Render cold starts)
  static Future<bool> wakeUpBackend() async {
    try {
      print('🔥 Waking up backend...');

      final response = await http
          .get(Uri.parse(baseUrl), headers: headers)
          .timeout(const Duration(seconds: 30));

      // Check if response contains the expected backend message
      if (response.statusCode == 200 &&
          response.body.contains('Pawsibilities Backend API is running')) {
        print('🔥 Backend is fully awake and responding!');
        return true;
      }

      return response.statusCode < 500;
    } catch (e) {
      print('🔥 Wake-up failed: $e');
      return false;
    }
  }

  /// Test backend connectivity
  static Future<bool> testBackend() async {
    try {
      final url = '$baseUrl/users/test';
      print('🧪 Testing backend at: $url');

      final res = await http.get(Uri.parse(url), headers: headers);
      print('🧪 Test response: ${res.statusCode} - ${res.body}');

      return res.statusCode == 200;
    } catch (e) {
      print('🧪 Backend test failed: $e');
      return false;
    }
  }

  /// Test backend connectivity with authentication
  static Future<void> testAuthenticatedEndpoint(String token) async {
    try {
      final url = '$baseUrl/users/me';
      print('🧪 Testing authenticated endpoint: $url');
      print('🔑 Using token: ${token.substring(0, 20)}...');

      final res = await http.get(Uri.parse(url), headers: authHeaders(token));

      print('🧪 Auth test response: ${res.statusCode}');
      print('🧪 Auth test body: ${res.body}');
    } catch (e) {
      print('🧪 Auth test failed: $e');
    }
  }

  // ── AUTH ───────────────────────────────────────────────────────────────

  /// Register a new user
  static Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
    String? userName,
    String? gender,
    String? address,
  }) async {
    final url = '$baseUrl/users/register';

    print('📝 Registering user: $firstName $lastName ($email)');

    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'userName':
          userName ?? '${firstName.toLowerCase()}${lastName.toLowerCase()}',
      'gender': gender ?? 'prefer_not_to_say',
      'address': address ?? '',
      'phone': phone ?? '',
      'email': email,
      'password': password,
    });

    try {
      final res = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 30));

      if (res.statusCode == 201) {
        print('✅ Registration successful!');
        return jsonDecode(res.body);
      }
      print('❌ Registration failed: ${res.statusCode} - ${res.body}');
      return null;
    } catch (e) {
      print('💥 Registration error: $e');
      return null;
    }
  }

  /// Login existing user
  static Future<Map<String, dynamic>?> login(
      {required String email, required String password}) async {
    final url = '$baseUrl/users/login';
    final res = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    print('Login error: ${res.statusCode} ${res.body}');
    return null;
  }

  /// Get user profile
  static Future<Map<String, dynamic>?> getUserProfile(String token) async {
    final url = '$baseUrl/users/me';

    try {
      print('📡 [API] Getting user profile from: $url');
      print('🔐 [API] Using token: ${token.substring(0, 20)}...');
      print(
          '📋 [API] Authorization header: Bearer ${token.substring(0, 20)}...');

      final res = await http.get(
        Uri.parse(url),
        headers: authHeaders(token),
      );

      print('📊 [API] Profile response status: ${res.statusCode}');
      print('📋 [API] Profile response body: ${res.body}');
      print('📋 [API] Response headers: ${res.headers}');

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print('✅ [API] Profile data parsed successfully');
        return data;
      } else if (res.statusCode == 401) {
        print('🔒 [API] Authentication failed - token might be invalid');
      } else if (res.statusCode == 404) {
        print('❌ [API] Endpoint not found - check backend routes');
      }

      return null;
    } catch (e) {
      print('💥 [API] Get profile exception: $e');
      return null;
    }
  }

  /// Update user profile
  static Future<bool> updateUserProfile(
      String token, Map<String, dynamic> userData) async {
    final url = '$baseUrl/users/profile';
    try {
      final res = await http.put(
        Uri.parse(url),
        headers: authHeaders(token),
        body: jsonEncode(userData),
      );
      if (res.statusCode == 200) {
        return true;
      }
      print('Update profile error: ${res.statusCode} ${res.body}');
      return false;
    } catch (e) {
      print('Update profile exception: $e');
      return false;
    }
  }

  // ── PET OPERATIONS ─────────────────────────────────────────────────────

  /// Fetch pets belonging to the current user
  static Future<List<Map<String, dynamic>>> getUserPets(String token) async {
    final url = '$baseUrl/pets/user';
    final res = await http.get(
      Uri.parse(url),
      headers: authHeaders(token),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(data['pets'] ?? []);
    }
    return [];
  }

  /// Fetch all available pets
  static Future<List<Map<String, dynamic>>> getAvailablePets(
      String token) async {
    final url = '$baseUrl/pets/available';
    final res = await http.get(
      Uri.parse(url),
      headers: authHeaders(token),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(data['pets'] ?? []);
    }
    return [];
  }

  /// Create a new pet
  static Future<Map<String, dynamic>?> createPet(
      String token, Map<String, dynamic> petData) async {
    final url = '$baseUrl/pets';
    final res = await http.post(
      Uri.parse(url),
      headers: authHeaders(token),
      body: jsonEncode(petData),
    );
    if (res.statusCode == 201) {
      return jsonDecode(res.body);
    }
    print('Create pet error: ${res.statusCode} ${res.body}');
    return null;
  }

  /// Delete a pet by ID
  static Future<bool> deletePet(String token, String petId) async {
    final url = '$baseUrl/pets/$petId';
    final res = await http.delete(
      Uri.parse(url),
      headers: authHeaders(token),
    );
    return res.statusCode == 200;
  }

  // ── MATCH OPERATIONS ────────────────────────────────────────────────────

  /// Create a match between two pets
  static Future<bool> createMatch(
      String token, String petId, String targetPetId) async {
    final url = '$baseUrl/matches';
    final res = await http.post(
      Uri.parse(url),
      headers: authHeaders(token),
      body: jsonEncode({'petId': petId, 'targetPetId': targetPetId}),
    );
    return res.statusCode == 201;
  }

  /// Fetch matches for the current user
  static Future<List<Map<String, dynamic>>> getMatches(String token) async {
    final url = '$baseUrl/matches';
    final res = await http.get(
      Uri.parse(url),
      headers: authHeaders(token),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(data['matches'] ?? []);
    }
    return [];
  }

  // ── COMMUNITY POSTS ────────────────────────────────────────────────────

  /// Fetch community posts
  static Future<List<Map<String, dynamic>>> getCommunityPosts(
      String token) async {
    final url = '$baseUrl/posts';
    final res = await http.get(
      Uri.parse(url),
      headers: authHeaders(token),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(data['posts'] ?? []);
    }
    return [];
  }

  /// Create a community post
  static Future<bool> createPost(
      String token, Map<String, dynamic> postData) async {
    final url = '$baseUrl/posts';
    final res = await http.post(
      Uri.parse(url),
      headers: authHeaders(token),
      body: jsonEncode(postData),
    );
    return res.statusCode == 201;
  }

  // ── LOST & FOUND ───────────────────────────────────────────────────────

  /// Fetch lost & found posts
  static Future<List<Map<String, dynamic>>> getLostFoundPosts(
      String token) async {
    final url = '$baseUrl/lostpets';
    final res = await http.get(
      Uri.parse(url),
      headers: authHeaders(token),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(data['posts'] ?? []);
    }
    return [];
  }

  /// Create a lost & found post
  static Future<bool> createLostFoundPost(
      String token, Map<String, dynamic> postData) async {
    final url = '$baseUrl/lostpets';
    final res = await http.post(
      Uri.parse(url),
      headers: authHeaders(token),
      body: jsonEncode(postData),
    );
    return res.statusCode == 201;
  }

  // ── IMAGE UPLOAD ───────────────────────────────────────────────────────

  /// Upload an image file to Firebase Storage and return its public URL
  static Future<String?> uploadImage(File imageFile,
      {String folder = 'uploads'}) async {
    try {
      return await StorageService.uploadFile(file: imageFile, folder: folder);
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }
}
