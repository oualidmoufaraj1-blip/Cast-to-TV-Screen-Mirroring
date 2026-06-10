import 'package:flutter/material.dart';

import 'preferences_service.dart';

class LocaleService {
  LocaleService._();

  static const supportedLocales = [
    Locale('en'),
    Locale('fr'),
    Locale('es'),
    Locale('ar'),
  ];

  static Locale get savedLocale {
    final code = PreferencesService.instance.localeCode;
    return Locale(code);
  }

  static Future<void> saveLocale(Locale locale) {
    return PreferencesService.instance.setLocaleCode(locale.languageCode);
  }

  static String languageLabel(String code) {
    return switch (code) {
      'fr' => 'Français',
      'es' => 'Español',
      'ar' => 'العربية',
      _ => 'English',
    };
  }

  static String languageLabelForLocale(Locale locale) {
    return languageLabel(locale.languageCode);
  }
}
