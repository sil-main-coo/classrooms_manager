import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static Future<bool> saveData(String key, var value) async {
    final prefs = await SharedPreferences.getInstance();
    if(value is int)
      return await prefs.setInt(key, value);
    else if(value is double)
      return await prefs.setDouble(key, value);
    else if(value is String)
      return await prefs.setString(key, value);
    else if(value is bool)
      return await prefs.setBool(key, value);
    else
      return await prefs.setStringList(key, value); // list String
  }

  static Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.get(key);
  }

  static Future<void> deleteDataWithKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}