import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/l10n_extension.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';
import '../connect/connect_screen.dart';

class RemoteControlScreen extends StatelessWidget {
  const RemoteControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(title: l10n.remoteControl),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          8,
          20,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          InfoCard(
            title: l10n.aboutRemote,
            icon: Icons.settings_remote_rounded,
            children: [
              Text(
                l10n.aboutRemoteBody,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InfoCard(
            title: l10n.whenAirplayActive,
            icon: Icons.tv_rounded,
            children: [
              InstructionStep(number: 1, text: l10n.remoteStep1),
              InstructionStep(number: 2, text: l10n.remoteStep2),
              InstructionStep(number: 3, text: l10n.remoteStep3),
            ],
          ),
          const SizedBox(height: 16),
          InfoCard(
            title: l10n.connectFirst,
            icon: Icons.link_rounded,
            children: [
              Text(
                l10n.connectFirstBody,
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
                      l10n.pickAirplayDevice,
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
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ConnectScreen(),
                ),
              );
            },
            icon: const Icon(Icons.wifi_rounded),
            label: Text(l10n.goToConnect),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'remote'),
    );
  }
}
