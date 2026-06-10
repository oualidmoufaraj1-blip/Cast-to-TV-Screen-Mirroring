import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Google UMP consent flow — required for EEA/UK users and AdMob CMP policy.
abstract final class ConsentService {
  static Future<void> requestConsent() async {
    final completer = Completer<void>();

    final params = ConsentRequestParameters(
      tagForUnderAgeOfConsent: false,
      consentDebugSettings: kDebugMode
          ? ConsentDebugSettings(
              debugGeography: DebugGeography.debugGeographyEea,
              testIdentifiers: const ['79738754EC81FA5F64972928128B2FFF'],
            )
          : null,
    );

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () {
        ConsentForm.loadAndShowConsentFormIfRequired((_) {
          if (!completer.isCompleted) completer.complete();
        });
      },
      (_) {
        if (!completer.isCompleted) completer.complete();
      },
    );

    await completer.future.timeout(
      const Duration(seconds: 15),
      onTimeout: () {},
    );
  }

  /// Opens the privacy options form when required (e.g. Settings).
  static Future<void> showPrivacyOptions() async {
    final completer = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((_) {
      if (!completer.isCompleted) completer.complete();
    });
    await completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {},
    );
  }

  static Future<bool> get isPrivacyOptionsRequired async {
    final status =
        await ConsentInformation.instance.getPrivacyOptionsRequirementStatus();
    return status == PrivacyOptionsRequirementStatus.required;
  }
}
