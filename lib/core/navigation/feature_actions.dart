import 'package:flutter/material.dart';

import '../../screens/browser/browser_screen.dart';
import '../../screens/connect/connect_screen.dart';
import '../../screens/link_video/link_video_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/photo/photo_screen.dart';
import '../../screens/remote/remote_control_screen.dart';
import '../../screens/screen_mirror/screen_mirror_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/video/video_screen.dart';
import '../../services/fullscreen_ad_service.dart';
import '../../services/haptic_service.dart';
import '../utils/link_validator.dart';

class FeatureActions {
  FeatureActions();

  Future<void> _tap(BuildContext context) => HapticService.selectionClick();

  Future<void> openOnboarding(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const OnboardingScreen(markCompleteOnFinish: false),
      ),
    );
  }

  Future<void> openSettings(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
    );
  }

  Future<void> openConnect(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showRewarded();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ConnectScreen()),
    );
  }

  Future<void> openCastConnectionGuide(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ConnectScreen()),
    );
  }

  Future<void> openScreenMirror(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showRewarded();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ScreenMirrorScreen()),
    );
  }

  Future<void> openRemoteControl(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const RemoteControlScreen()),
    );
  }

  Future<void> openYoutube(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const LinkVideoScreen(platform: LinkVideoPlatform.youtube),
      ),
    );
  }

  Future<void> openVimeo(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const LinkVideoScreen(platform: LinkVideoPlatform.vimeo),
      ),
    );
  }

  Future<void> openBrowser(BuildContext context) async {
    await _tap(context);
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const BrowserScreen()),
    );
  }

  Future<void> openPhoto(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const PhotoScreen()),
    );
  }

  Future<void> openVideo(BuildContext context) async {
    await _tap(context);
    await FullScreenAdService.showInterstitial();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const VideoScreen()),
    );
  }
}
