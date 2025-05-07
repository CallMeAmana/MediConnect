import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = true;
  
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  
  // Initialize and check if user is logged in
  Future<void> initAuth() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Check if user is logged in using shared preferences
      final userString = await _storageService.read('user');
      
      if (userString != null && userString.isNotEmpty) {
        final userData = jsonDecode(userString);
        _currentUser = User.fromJson(userData);
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        _currentUser = null;
      }
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Login user
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Get all registered users
      final usersString = await _storageService.read('users');
      
      if (usersString != null && usersString.isNotEmpty) {
        final List<dynamic> usersData = jsonDecode(usersString);
        
        // Find user with matching email and password
        for (var userData in usersData) {
          final user = User.fromJson(userData);
          
          if (user.email == email && user.password == password) {
            _currentUser = user;
            _isAuthenticated = true;
            
            // Save current user
            await _storageService.write('user', jsonEncode(user.toJson()));
            
            _isLoading = false;
            notifyListeners();
            return true;
          }
        }
      }
      
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Register user
  Future<bool> register(String name, String email, String password, UserType type) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Check if user already exists
      final usersString = await _storageService.read('users');
      List<dynamic> usersData = [];
      
      if (usersString != null && usersString.isNotEmpty) {
        usersData = jsonDecode(usersString);
        
        // Check if email already exists
        for (var userData in usersData) {
          final user = User.fromJson(userData);
          
          if (user.email == email) {
            _isLoading = false;
            notifyListeners();
            return false; // Email already exists
          }
        }
      }
      
      // Create new user
      final newUser = User(
        name: name,
        email: email,
        password: password,
        type: type, id: '',
      );
      
      // Add user to list
      usersData.add(newUser.toJson());
      
      // Save users list
      await _storageService.write('users', jsonEncode(usersData));
      
      // Set current user and save
      _currentUser = newUser;
      _isAuthenticated = true;
      await _storageService.write('user', jsonEncode(newUser.toJson()));
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Logout user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _storageService.delete('user');
      _currentUser = null;
      _isAuthenticated = false;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Password recovery simulation
  Future<bool> sendPasswordRecovery(String email) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Check if user exists with given email
      final usersString = await _storageService.read('users');
      
      if (usersString != null && usersString.isNotEmpty) {
        final List<dynamic> usersData = jsonDecode(usersString);
        
        for (var userData in usersData) {
          final user = User.fromJson(userData);
          
          if (user.email == email) {
            // In a real app, would send an email here
            // For demo, we just simulate successful sending
            _isLoading = false;
            notifyListeners();
            return true;
          }
        }
      }
      
      _isLoading = false;
      notifyListeners();
      return false; // Email not found
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}