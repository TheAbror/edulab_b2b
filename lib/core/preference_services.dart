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
  //
  static bool? getAuthStatus() {
    return _getPrefs().getBool(ShPrefKeys.authStatus);
  }

  static Future<bool> saveAuthStatus(bool? isAuthorized) async {
    return _getPrefs().setBool(ShPrefKeys.authStatus, isAuthorized ?? false);
  }
  //

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

  //APP VERSION
  static Future<int?> getMinimumAppVersion() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(ShPrefKeys.minAppVersion);
  }

  static Future<bool> saveMinimumAppVersion(int minAppVersion) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setInt(ShPrefKeys.minAppVersion, minAppVersion);
  }

  static Future<int?> getLatestAppVersion() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(ShPrefKeys.latestAppVersion);
  }

  static Future<bool> saveLatestAppVersion(int latestAppVersion) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setInt(ShPrefKeys.latestAppVersion, latestAppVersion);
  }

  static Future<bool?> getShowMaintenance() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(ShPrefKeys.showMaintenance);
  }

  static Future<bool?> saveShowMaintenance(bool showMaintenance) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(ShPrefKeys.showMaintenance, showMaintenance);
  }

  static Future<String?> getAppVersionTitle() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(ShPrefKeys.appVersionTitle);
  }

  static Future<bool?> saveAppVersionTitle(String appVersionTitle) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(ShPrefKeys.appVersionTitle, appVersionTitle);
  }

  static Future<String?> getAppVersionDescription() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(ShPrefKeys.appVersionDescription);
  }

  static Future<bool?> saveAppVersionDescription(
    String appVersionDescription,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(
      ShPrefKeys.appVersionDescription,
      appVersionDescription,
    );
  }

  static Future<String?> getAndroidStoreUrl() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(ShPrefKeys.androidStoreUrl);
  }

  static Future<bool?> saveAndroidStoreUrl(String androidStoreUrl) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(ShPrefKeys.androidStoreUrl, androidStoreUrl);
  }

  static Future<String?> getIOSstoreUrl() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(ShPrefKeys.iosStoreUrl);
  }

  static Future<bool?> saveIOSstoreUrl(String iosStoreUrl) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(ShPrefKeys.iosStoreUrl, iosStoreUrl);
  }
}
