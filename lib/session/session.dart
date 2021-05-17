import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static setSession(String key, dynamic value) async {
    final SharedPreferences session = await SharedPreferences.getInstance();
    session.setString(key, value.toString());
  }

  static getSession(String key) async {
    final SharedPreferences session = await SharedPreferences.getInstance();
    return session.getString(key);
  }
}
