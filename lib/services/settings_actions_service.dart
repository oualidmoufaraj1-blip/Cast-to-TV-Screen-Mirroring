import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../core/constants/app_constants.dart';
import '../l10n/l10n_extension.dart';
import '../screens/browser/browser_screen.dart';
import 'haptic_service.dart';

class SettingsActionsService {
  SettingsActionsService._();

  static Future<void> shareApp(BuildContext context) async {
    final l10n = context.l10n;
    await HapticService.lightImpact();
    if (!context.mounted) return;
    await Share.share(
      '${l10n.castToTv}\n${AppConstants.appStoreUrl}',
      subject: l10n.appName,
    );
  }

  static Future<void> contactUs(BuildContext context) async {
    await _openInAppBrowser(context, AppConstants.contactUsUrl);
  }

  static Future<void> openPrivacyPolicy(BuildContext context) async {
    await _openInAppBrowser(context, AppConstants.privacyPolicyUrl);
  }

  static Future<void> openTermsOfUse(BuildContext context) async {
    await _openInAppBrowser(context, AppConstants.termsOfUseUrl);
  }

  static Future<void> rateApp(BuildContext context) async {
    await HapticService.lightImpact();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.rateAppMessage)),
    );
  }

  static Future<void> _openInAppBrowser(
    BuildContext context,
    String url,
  ) async {
    await HapticService.lightImpact();
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BrowserScreen(initialUrl: url),
      ),
    );
  }
}
