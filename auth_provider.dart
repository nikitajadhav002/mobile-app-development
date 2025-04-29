import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<bool> login(String username, String password) async {
    print('AuthProvider: Attempting login');
    final user = await _authService.login(username, password);
    if (user != null) {
      print('AuthProvider: Login successful, user: ${user.username}');
      _user = user;
      notifyListeners();
      return true;
    }
    print('AuthProvider: Login failed');
    return false;
  }

  Future<bool> signup(String username, String password) async {
    final user = await _authService.signup(username, password);
    if (user != null) {
      _user = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }
}
