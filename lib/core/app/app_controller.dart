import 'package:flutter/material.dart';

import '../../services/locale_service.dart';
import '../../services/theme_service.dart';

class AppController extends ChangeNotifier {
  AppController._();

  static final AppController instance = AppController._();

  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.system;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  Future<void> initialize() async {
    _locale = LocaleService.savedLocale;
    _themeMode = ThemeService.savedThemeMode;
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    await LocaleService.saveLocale(locale);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    await ThemeService.saveThemeMode(mode);
    notifyListeners();
  }
}
