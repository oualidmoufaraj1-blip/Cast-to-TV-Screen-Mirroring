import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../util/global.dart';

/// Standard AdMob banner height (AdSize.banner).
const double kBannerAdHeight = 50;

/// Bottom banner ad bar. Each screen should pass a unique [placement] key.
class BannerAdBar extends StatefulWidget {
  const BannerAdBar({super.key, required this.placement});

  final String placement;

  @override
  State<BannerAdBar> createState() => _BannerAdBarState();
}

class _BannerAdBarState extends State<BannerAdBar> {
  late final Key _adKey = ValueKey('banner_${widget.placement}');
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    if (!gAdsReady || !gAds.hasBanners) return;

    gAds.bannerInstance.loadBannerAd(() {
      if (mounted) setState(() => _loaded = true);
    }, _adKey);
  }

  @override
  void dispose() {
    if (gAdsReady) {
      gAds.bannerInstance.disposeBanner(_adKey);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!gAdsReady || !gAds.hasBanners || !_loaded) {
      return const SizedBox.shrink();
    }

    return Material(
      color: context.screenBackground,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: kBannerAdHeight,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.screenBackground,
              border: Border(
                top: BorderSide(
                  color: context.isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                ),
              ),
            ),
            child: Center(
              child: gAds.bannerInstance.getBannerAdWidget(_adKey),
            ),
          ),
        ),
      ),
    );
  }
}
