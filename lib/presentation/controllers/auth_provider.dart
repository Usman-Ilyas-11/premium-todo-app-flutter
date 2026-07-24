import 'package:flutter/material.dart';

import '../../core/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _loggedIn = false;
  String _userName = "";
  String _email = "";

  bool get isLoggedIn => _loggedIn;

  String get userName => _userName;

  String get email => _email;

  Future<void> loadUser() async {
    _loggedIn = await _authService.isLoggedIn();

    _userName = await _authService.getUserName();

    _email = await _authService.getEmail();

    notifyListeners();
  }

  Future<void> login({
    required String username,
    required String email,
  }) async {
    await _authService.login(
      username: username,
      email: email,
    );

    await loadUser();
  }

  Future<void> logout() async {
    await _authService.logout();

    await loadUser();
  }
}