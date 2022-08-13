import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences!.getBool(key);
  }

  static Future setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  static getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> clearData({
    required String key,
  }) async{
   return await sharedPreferences!.remove(key);
  }
}
