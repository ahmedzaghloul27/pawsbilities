import 'package:flutter/material.dart';
import '../models/pet_model.dart';
import '../services/api_service.dart';
import '../services/auth_manager.dart';

class PetProvider extends ChangeNotifier {
  static final PetProvider _instance = PetProvider._internal();
  factory PetProvider() => _instance;
  PetProvider._internal();

  List<Pet> _userPets = [];
  List<Pet> _availablePets = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Pet> get userPets => _userPets;
  List<Pet> get availablePets => _availablePets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load user's pets
  Future<void> loadUserPets() async {
    final authManager = AuthManager();
    if (!authManager.isAuthenticated || authManager.token == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final petsData = await ApiService.getUserPets(authManager.token!);
      _userPets = petsData.map((petData) => Pet.fromMap(petData)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load user pets: $e';
      print('Error loading user pets: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Load available pets for matching
  Future<void> loadAvailablePets() async {
    final authManager = AuthManager();
    if (!authManager.isAuthenticated || authManager.token == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final petsData = await ApiService.getAvailablePets(authManager.token!);
      _availablePets = petsData.map((petData) => Pet.fromMap(petData)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load available pets: $e';
      print('Error loading available pets: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Add a new pet
  Future<bool> addPet(Map<String, dynamic> petData) async {
    final authManager = AuthManager();
    if (!authManager.isAuthenticated || authManager.token == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.createPet(authManager.token!, petData);
      if (response != null) {
        // Add the new pet to the local list
        final newPet = Pet.fromMap(response['pet']);
        _userPets.add(newPet);
        _error = null;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _error = 'Failed to add pet: $e';
      print('Error adding pet: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Remove a pet
  Future<bool> removePet(String petId) async {
    final authManager = AuthManager();
    if (!authManager.isAuthenticated || authManager.token == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await ApiService.deletePet(authManager.token!, petId);
      if (success) {
        // Remove the pet from the local list
        _userPets.removeWhere((pet) => pet.id == petId);
        _error = null;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _error = 'Failed to remove pet: $e';
      print('Error removing pet: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Get a specific pet by ID
  Pet? getPetById(String petId) {
    try {
      return _userPets.firstWhere((pet) => pet.id == petId);
    } catch (e) {
      try {
        return _availablePets.firstWhere((pet) => pet.id == petId);
      } catch (e) {
        return null;
      }
    }
  }

  /// Clear all pet data (for logout)
  void clearPets() {
    _userPets.clear();
    _availablePets.clear();
    _error = null;
    notifyListeners();
  }

  /// Refresh all pet data
  Future<void> refreshAllPets() async {
    await Future.wait([
      loadUserPets(),
      loadAvailablePets(),
    ]);
  }
}
