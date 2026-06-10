import 'package:flutter/material.dart';

import 'preferences_service.dart';

enum AppAppearance { system, light, dark }

class ThemeService {
  ThemeService._();

  static ThemeMode get savedThemeMode {
    final value = PreferencesService.instance.themeMode;
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static AppAppearance get savedAppearance {
    final value = PreferencesService.instance.themeMode;
    return switch (value) {
      'light' => AppAppearance.light,
      'dark' => AppAppearance.dark,
      _ => AppAppearance.system,
    };
  }

  static Future<void> saveThemeMode(ThemeMode mode) {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    return PreferencesService.instance.setThemeMode(value);
  }

  static Future<void> saveAppearance(AppAppearance appearance) {
    final value = switch (appearance) {
      AppAppearance.light => 'light',
      AppAppearance.dark => 'dark',
      AppAppearance.system => 'system',
    };
    return PreferencesService.instance.setThemeMode(value);
  }
}
