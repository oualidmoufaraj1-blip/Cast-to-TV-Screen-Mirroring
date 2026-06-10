import 'package:flutter/material.dart';

import '../../services/fullscreen_ad_service.dart';

/// Navigation helpers that show interstitial ads before going back.
abstract final class NavigationHelper {
  static Future<void> popWithInterstitial(BuildContext context) async {
    await FullScreenAdService.showInterstitial();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
