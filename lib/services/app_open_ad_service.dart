import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multiads/multiads.dart';

import '../util/global.dart';

/// Shows a cold-start app open ad once per session without blocking navigation.
class AppOpenAdService {
  AppOpenAdService._();

  static bool _shownThisSession = false;
  static bool _isColdStart = true;
  static bool _hasBeenBackgrounded = false;

  /// Call once from [main] before [runApp].
  static void markColdStart() {
    _isColdStart = true;
    _shownThisSession = false;
    _hasBeenBackgrounded = false;
  }

  /// Call when the app leaves the foreground (background / inactive).
  static void onAppBackgrounded() {
    _hasBeenBackgrounded = true;
    _isColdStart = false;
  }

  /// Call when the app returns to the foreground after backgrounding.
  static void onAppResumed() {
    // Ignore the initial resumed event on cold launch; only track real resumes.
    if (_hasBeenBackgrounded) {
      _isColdStart = false;
    }
  }

  /// Waits for a preloaded app open ad, shows it if ready, then returns.
  /// Safe to call when ads are unavailable — returns immediately.
  static Future<void> showOnLaunchIfAvailable({
    required bool onboardingCompleted,
    Duration loadTimeout = const Duration(seconds: 4),
    Duration dismissTimeout = const Duration(seconds: 60),
  }) async {
    if (!_canShow(onboardingCompleted)) return;

    final ads = gAds.openAdsInstance;
    final loaded = await _waitForReady(
      ads,
      loadTimeout,
      onboardingCompleted: onboardingCompleted,
    );
    if (!loaded || !_canShow(onboardingCompleted)) return;

    _shownThisSession = true;
    _isColdStart = false;

    final completer = Completer<void>();

    void onFinished() {
      if (!completer.isCompleted) completer.complete();
    }

    AdCallbacks.onAppOpenFinished = onFinished;
    try {
      ads.showAdIfAvailableOpenAds();
      await completer.future.timeout(dismissTimeout, onTimeout: onFinished);
    } finally {
      AdCallbacks.onAppOpenFinished = null;
    }
  }

  static bool _canShow(bool onboardingCompleted) {
    if (!onboardingCompleted) return false;
    if (!_isColdStart) return false;
    if (!gAdsReady || !gAds.hasAppOpen) return false;
    if (_shownThisSession || isInterShowed) return false;

    final state = WidgetsBinding.instance.lifecycleState;
    if (state != null && state != AppLifecycleState.resumed) {
      return false;
    }

    return true;
  }

  static Future<bool> _waitForReady(
    Ads ads,
    Duration timeout, {
    required bool onboardingCompleted,
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      if (!_canShow(onboardingCompleted)) return false;
      if (ads.isAppOpenAdReady) return true;
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
    return _canShow(onboardingCompleted) && ads.isAppOpenAdReady;
  }
}
