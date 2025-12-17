import 'package:leti_mobile/widget_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServices {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences _getPrefs() {
    final pref = _prefs;
    if (pref != null) {
      return pref;
    } else {
      throw Exception('SharedPreferences is not inited');
    }
  }

  static void dispose() => _prefs = null;

  static bool? getTheme() {
    return _getPrefs().getBool(ShPrefKeys.theme);
  }

  static Future<bool> saveTheme(bool? isLight) async {
    if (isLight == null) {
      return _getPrefs().remove(ShPrefKeys.theme);
    }

    return _getPrefs().setBool(ShPrefKeys.theme, isLight);
  }

  static String? getToken() {
    return _getPrefs().getString(ShPrefKeys.token);
  }

  static Future<bool> saveToken(String token) async {
    return _getPrefs().setString(ShPrefKeys.token, token);
  }

  static String? getLangCode() {
    return _getPrefs().getString(ShPrefKeys.lang);
  }

  static Future<bool> saveLangCode(String lang) async {
    return _getPrefs().setString(ShPrefKeys.lang, lang);
  }

  static Future<bool> saveUserInfo(LocalStorageUserInfo userInfo) async {
    final jsonString = jsonEncode(userInfo.toJson());
    return _getPrefs().setString(ShPrefKeys.userInfo, jsonString);
  }

  static LocalStorageUserInfo? getUserInfo() {
    final jsonString = _getPrefs().getString(ShPrefKeys.userInfo);
    if (jsonString == null) return null;

    return LocalStorageUserInfo.fromJson(jsonDecode(jsonString));
  }

  static Future<bool> clearAll() async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.clear();
  }
}
