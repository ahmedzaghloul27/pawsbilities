import 'package:flutter/material.dart';
import 'api_service.dart';

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  String? _token;
  Map<String, dynamic>? _currentUser;
  bool _isAuthenticated = false;

  // Getters
  String? get token => _token;
  Map<String, dynamic>? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _currentUser?['_id'];

  /// Login user
  Future<bool> login(String email, String password) async {
    try {
      final response = await ApiService.login(email: email, password: password);

      if (response != null) {
        _token = response['token'];
        _currentUser = response['user'];
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  /// Register user
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
    String? location,
  }) async {
    try {
      final response = await ApiService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        location: location,
      );

      if (response != null) {
        _token = response['token'];
        _currentUser = response['user'];
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  /// Logout user
  void logout() {
    _token = null;
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  /// Update user profile
  Future<bool> updateProfile(Map<String, dynamic> userData) async {
    if (_token == null) return false;

    try {
      final success = await ApiService.updateUserProfile(_token!, userData);
      if (success) {
        // Update local user data
        _currentUser = {..._currentUser!, ...userData};
        notifyListeners();
      }
      return success;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }

  /// Get fresh user profile from server
  Future<void> refreshProfile() async {
    if (_token == null) return;

    try {
      final userData = await ApiService.getUserProfile(_token!);
      if (userData != null) {
        _currentUser = userData['user'];
        notifyListeners();
      }
    } catch (e) {
      print('Refresh profile error: $e');
    }
  }
}
