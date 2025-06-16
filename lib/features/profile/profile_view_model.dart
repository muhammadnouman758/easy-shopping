import 'package:flutter/material.dart';
import 'package:tera/features/profile/user_model.dart';

class ProfileViewModel with ChangeNotifier {
  User _user = User(
    id: 'user123',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+1 (555) 123-4567',
    imageUrl: 'assets/images/profile.jpg',
    joinDate: DateTime(2023, 1, 15),
  );

  bool _darkMode = false;
  bool _notificationsEnabled = true;
  bool _biometricAuth = false;

  User get user => _user;
  bool get darkMode => _darkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get biometricAuth => _biometricAuth;

  void updateProfile(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
    // In a real app, you would save this preference
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleBiometricAuth(bool value) {
    _biometricAuth = value;
    notifyListeners();
  }

  Future<void> logout() async {
    // Simulate logout process
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, you would clear user session and navigate to login
  }
}