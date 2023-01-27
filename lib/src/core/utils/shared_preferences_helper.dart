import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static void savePreferencesBool(String key, bool data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, data);
  }

  static Future<bool> getPreferencesBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool data = prefs.getBool(key) ?? false;
    return data;
  }

  static void savePreferencesInt(String key, int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, data);
  }

  static Future<int> getPreferencesInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int data = prefs.getInt(key) ?? -1;
    return data;
  }
}
