/// Full-screen ads are disabled. Methods are no-ops so any leftover call sites
/// cannot create review/production differences (Guideline 5.6).
class FullScreenAdService {
  FullScreenAdService._();

  static Future<void> showInterstitial({
    Duration dismissTimeout = const Duration(seconds: 60),
  }) async {}

  static Future<void> showRewarded({
    Duration dismissTimeout = const Duration(seconds: 60),
  }) async {}
}
