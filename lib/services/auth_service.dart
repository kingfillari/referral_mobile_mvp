import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  Future<bool> login(String username, String password) async {

    if (username == "doctor" && password == "1234") {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", "logged_in");

      return true;
    }

    return false;
  }
}