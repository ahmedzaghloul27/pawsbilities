import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import '../models/user_model.dart';

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  String? _token;
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  // Getters
  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _currentUser?.id;
  String get userName => _currentUser?.firstName ?? 'User';
  String get userFullName => _currentUser?.fullName ?? 'Unknown User';

  /// Initialize AuthManager - check for existing session
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString('auth_token');

      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;
        await _loadUserProfile();
      }
    } catch (e) {
      print('Error initializing auth: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Login user
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.login(email: email, password: password);

      if (response != null && response['token'] != null) {
        _token = response['token'];

        // Save token to persistent storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);

        // Load user profile
        await _loadUserProfile();

        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Login error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Register user
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        address: address,
      );

      // Check if registration was successful
      if (response != null) {
        print('📝 [AUTH] Registration response: $response');

        // If backend returns a token, use it for auto-login
        if (response['token'] != null) {
          _token = response['token'];

          // Save token to persistent storage
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', _token!);

          // Load user profile
          await _loadUserProfile();

          _isAuthenticated = true;
          print('📝 [AUTH] Registration successful with auto-login');
        } else {
          // Registration successful but no auto-login token
          print(
              '📝 [AUTH] Registration successful, user needs to login manually');
        }

        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Registration error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Load user profile from API
  Future<void> _loadUserProfile() async {
    if (_token == null) {
      print('🚫 [AUTH] Cannot load profile: no token');
      return;
    }

    try {
      print('📥 [AUTH] Loading user profile...');
      print('🔑 [AUTH] Token: ${_token!.substring(0, 20)}...');

      // Test the authentication first
      await ApiService.testAuthenticatedEndpoint(_token!);

      final userData = await ApiService.getUserProfile(_token!);
      print('📋 [AUTH] Profile response: $userData');

      if (userData != null) {
        Map<String, dynamic>? userMap;

        // Try different response formats
        if (userData['user'] != null) {
          // Format: { user: { firstName: "...", ... } }
          userMap = userData['user'];
          print('📦 [AUTH] Using nested user data');
        } else if (userData['data'] != null) {
          // Format: { data: { firstName: "...", ... } }
          userMap = userData['data'];
          print('📦 [AUTH] Using nested data');
        } else if (userData['firstName'] != null || userData['email'] != null) {
          // Format: { firstName: "...", lastName: "...", ... }
          userMap = userData;
          print('📦 [AUTH] Using direct user data');
        }

        if (userMap != null) {
          _currentUser = User.fromMap(userMap);
          _isAuthenticated = true;
          print(
              '✅ [AUTH] Profile loaded successfully: ${_currentUser?.firstName} ${_currentUser?.lastName}');
        } else {
          print('❌ [AUTH] No recognizable user data in response');
        }
      } else {
        print('❌ [AUTH] No response data');
      }
    } catch (e) {
      print('💥 [AUTH] Load profile error: $e');
      // If profile loading fails, might be invalid token
      await logout();
    }
  }

  /// Logout user
  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _isAuthenticated = false;

    // Clear persistent storage
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    } catch (e) {
      print('Error clearing auth data: $e');
    }

    notifyListeners();
  }

  /// Update user profile
  Future<bool> updateProfile(Map<String, dynamic> userData) async {
    if (_token == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final success = await ApiService.updateUserProfile(_token!, userData);
      if (success) {
        // Refresh user profile from server
        await _loadUserProfile();
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Update profile error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Get fresh user profile from server
  Future<void> refreshProfile() async {
    if (_token == null) return;

    try {
      await _loadUserProfile();
      notifyListeners();
    } catch (e) {
      print('Refresh profile error: $e');
    }
  }

  /// Check if user is authenticated
  bool requireAuth() {
    return _isAuthenticated && _token != null && _currentUser != null;
  }
}
