import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';

class PreferencesService {
  PreferencesService._(this._prefs);

  static PreferencesService? _instance;

  final SharedPreferences _prefs;

  static Future<void> init() async {
    _instance = PreferencesService._(await SharedPreferences.getInstance());
  }

  static PreferencesService get instance {
    final service = _instance;
    if (service == null) {
      throw StateError('PreferencesService.init() must be called first.');
    }
    return service;
  }

  bool get isOnboardingCompleted =>
      _prefs.getBool(AppConstants.onboardingCompletedKey) ?? false;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(AppConstants.onboardingCompletedKey, value);

  bool get isVibrateEnabled =>
      _prefs.getBool(AppConstants.vibrateFeedbackKey) ?? true;

  Future<void> setVibrateEnabled(bool value) =>
      _prefs.setBool(AppConstants.vibrateFeedbackKey, value);

  String get localeCode => _prefs.getString(AppConstants.localeKey) ?? 'en';

  Future<void> setLocaleCode(String code) =>
      _prefs.setString(AppConstants.localeKey, code);

  String get themeMode => _prefs.getString(AppConstants.themeModeKey) ?? 'system';

  Future<void> setThemeMode(String mode) =>
      _prefs.setString(AppConstants.themeModeKey, mode);
}
