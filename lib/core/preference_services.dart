import 'package:leti_mobile/core/local_datasource/model/shared_keys.dart';
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

  static String? getToken() {
    return _getPrefs().getString(ShPrefKeys.token);
  }

  static Future<bool> saveToken(String token) async {
    return _getPrefs().setString(ShPrefKeys.token, token);
  }
}
