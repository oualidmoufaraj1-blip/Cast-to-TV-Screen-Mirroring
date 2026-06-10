import 'package:flutter/services.dart';

import 'preferences_service.dart';

class HapticService {
  HapticService._();

  static Future<void> selectionClick() async {
    if (!PreferencesService.instance.isVibrateEnabled) return;
    await HapticFeedback.selectionClick();
  }

  static Future<void> lightImpact() async {
    if (!PreferencesService.instance.isVibrateEnabled) return;
    await HapticFeedback.lightImpact();
  }

  static Future<void> mediumImpact() async {
    if (!PreferencesService.instance.isVibrateEnabled) return;
    await HapticFeedback.mediumImpact();
  }
}
