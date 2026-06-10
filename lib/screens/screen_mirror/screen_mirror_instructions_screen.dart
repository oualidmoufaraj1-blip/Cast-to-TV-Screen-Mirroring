import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/l10n_extension.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';

class ScreenMirrorInstructionsScreen extends StatelessWidget {
  const ScreenMirrorInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(title: l10n.screenMirroringGuide),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          8,
          20,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          InfoCard(
            title: l10n.beforeYouStart,
            icon: Icons.wifi_rounded,
            children: [
              InstructionStep(number: 1, text: l10n.beforeStep1),
              InstructionStep(number: 2, text: l10n.beforeStep2),
              InstructionStep(number: 3, text: l10n.beforeStep3),
            ],
          ),
          const SizedBox(height: 16),
          InfoCard(
            title: l10n.startFromControlCenter,
            icon: Icons.control_camera_rounded,
            children: [
              InstructionStep(number: 1, text: l10n.ccStep1),
              InstructionStep(number: 2, text: l10n.step2Body),
              InstructionStep(number: 3, text: l10n.step3Body),
              InstructionStep(number: 4, text: l10n.ccStep4),
              InstructionStep(number: 5, text: l10n.ccStep5),
            ],
          ),
          const SizedBox(height: 16),
          InfoCard(
            title: l10n.airplayForVideo,
            icon: Icons.play_circle_outline_rounded,
            children: [
              Text(
                l10n.airplayForVideoBody,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.secondaryText,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.chooseAirplayDevice,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: context.primaryText,
                      ),
                    ),
                  ),
                  const AirPlayRoutePicker(width: 48, height: 48),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'mirror_guide'),
    );
  }
}
