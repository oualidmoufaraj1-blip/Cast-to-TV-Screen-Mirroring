/// App-open ads are disabled for Guideline 5.6 consistency.
class AppOpenAdService {
  AppOpenAdService._();

  static void markColdStart() {}

  static void onAppBackgrounded() {}

  static void onAppResumed() {}

  static Future<void> showOnLaunchIfAvailable({
    required bool onboardingCompleted,
    Duration loadTimeout = const Duration(seconds: 4),
    Duration dismissTimeout = const Duration(seconds: 60),
  }) async {}
}
