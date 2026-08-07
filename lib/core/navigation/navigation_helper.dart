import 'package:flutter/material.dart';

/// Navigation helpers. Do not insert ads on back navigation (Guideline 5.6).
abstract final class NavigationHelper {
  static Future<void> popWithInterstitial(BuildContext context) async {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
