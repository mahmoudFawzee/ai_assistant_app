import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferencesService get instance {
    _instance ??= SharedPreferencesService._();
    return _instance!;
  }

  SharedPreferencesService._();

  Future<SharedPreferences> get _preferences async =>
      await SharedPreferences.getInstance();

  Future<bool> setString(String key, String value) async {
    final preferences = await _preferences;
    return await preferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final preferences = await _preferences;
    return preferences.getString(key);
  }

  Future<bool> remove(String key) async {
    final preferences = await _preferences;
    return await preferences.remove(key);
  }

  Future<bool> setBool(String key, bool value) async {
    final preferences = await _preferences;
    return await preferences.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final preferences = await _preferences;

    return preferences.getBool(key) ?? false;
  }
}
