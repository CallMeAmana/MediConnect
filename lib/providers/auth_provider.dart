
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

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
      final fbUser = fbAuth.FirebaseAuth.instance.currentUser;
      if (fbUser != null) {
        final doc = await usersCollection.doc(fbUser.uid).get();
        if (doc.exists) {
          _currentUser = User.fromJson(doc.data() as Map<String, dynamic>);
          _isAuthenticated = true;
        } else {
          _currentUser = null;
          _isAuthenticated = false;
        }
      } else {
        _currentUser = null;
        _isAuthenticated = false;
      }
    } catch (e) {
      _currentUser = null;
      _isAuthenticated = false;
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
      final credential = await fbAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final doc = await usersCollection.doc(credential.user!.uid).get();
      if (doc.exists) {
        _currentUser = User.fromJson(doc.data() as Map<String, dynamic>);
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isAuthenticated = false;
        _currentUser = null;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;
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
      // 1. Create user in Firebase Auth
      final credential = await fbAuth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 2. Store additional info in Firestore (do NOT store password)
      final user = User(
        id: credential.user!.uid,
        name: name,
        email: email,
        password: '', // Never store password
        type: type,
      );
      await usersCollection.doc(credential.user!.uid).set(user.toJson());
      _currentUser = user;
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } on fbAuth.FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
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
      await fbAuth.FirebaseAuth.instance.signOut();
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
      await fbAuth.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}