import 'package:flutter/material.dart';
import 'package:shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'en'; // Default to English
  bool _notificationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _language = prefs.getString('language') ?? 'en';
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    _language = languageCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    notifyListeners();
  }
}