import 'dart:async';

import 'package:multiads/multiads.dart';

import '../util/global.dart';

/// Shows interstitial and rewarded ads with safe fallbacks.
class FullScreenAdService {
  FullScreenAdService._();

  static Future<void> showInterstitial({
    Duration dismissTimeout = const Duration(seconds: 60),
  }) async {
    if (!gAdsReady || !gAds.hasInterstitials || isInterShowed) {
      return;
    }

    final completer = Completer<void>();

    void onFinished() {
      if (!completer.isCompleted) completer.complete();
    }

    AdCallbacks.onInterstitialDismissed = onFinished;
    try {
      gAds.interInstance.showInterstitialAd();
      await completer.future.timeout(dismissTimeout, onTimeout: onFinished);
    } finally {
      AdCallbacks.onInterstitialDismissed = null;
    }
  }

  static Future<void> showRewarded({
    Duration dismissTimeout = const Duration(seconds: 60),
  }) async {
    if (!gAdsReady || !gAds.hasRewarded || isInterShowed) {
      return;
    }

    final completer = Completer<void>();

    void onFinished() {
      if (!completer.isCompleted) completer.complete();
    }

    gAds.rewardInstance.showRewardAd(onFinished);
    await completer.future.timeout(dismissTimeout, onTimeout: onFinished);
  }
}
