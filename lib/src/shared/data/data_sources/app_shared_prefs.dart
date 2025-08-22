

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/constant/local_storage_constants.dart';
import '../../domain/entities/language_enum.dart';

class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);

  /// __________ Language __________ ///
  LanguageEnum? getLang() {
    String? data = _preferences.getString(lang);
    if (data == null) {
      return LanguageEnum.en;
    }
    return LanguageEnum.values.firstWhere((element) => element.local == data);
  }

  void setLang(LanguageEnum language) {
    _preferences.setString(lang, language.local);
  }

  /// __________ Dark Theme __________ ///
  bool getIsDarkTheme() {
    return _preferences.getBool(theme) ?? false;
  }

  void setDarkTheme(bool isDark) {
    _preferences.setBool(theme, isDark);
  }

  bool getRememberMe() => _preferences.getBool(rememberMeKey) ?? false;

  String getSavedEmail() => _preferences.getString(emailKey) ?? '';

  String getSavedPassword() => _preferences.getString(passwordKey) ?? '';

  Future<void> saveCredentials({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await _preferences.setBool(rememberMeKey, rememberMe);
    await _preferences.setString(emailKey, email);
    await _preferences.setString(passwordKey, password);
  }

  Future<void> clearCredentials() async {
    await _preferences.remove(rememberMeKey);
    await _preferences.remove(emailKey);
    await _preferences.remove(passwordKey);
  }
}

