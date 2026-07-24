import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _loginKey = "isLoggedIn";
  static const String _userNameKey = "userName";
  static const String _emailKey = "email";

  /// Save login session
  Future<void> login({
    required String username,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_loginKey, true);
    await prefs.setString(_userNameKey, username);
    await prefs.setString(_emailKey, email);

    print("Saved Username: ${prefs.getString(_userNameKey)}");
    print("Saved Email: ${prefs.getString(_emailKey)}");
  }

  /// Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_loginKey, false);
    await prefs.remove(_userNameKey);
    await prefs.remove(_emailKey);
  }

  /// Is user logged in?
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_loginKey) ?? false;
  }

  /// Username
  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userNameKey) ?? "";
  }

  /// Email
  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_emailKey) ?? "";
  }
}