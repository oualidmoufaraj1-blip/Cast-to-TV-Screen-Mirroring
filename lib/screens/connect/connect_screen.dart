import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/empty_state.dart';
import '../screen_mirror/screen_mirror_instructions_screen.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(title: l10n.connectToTv),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          padding,
          8,
          padding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          PageHeader(
            title: l10n.connectToTv,
            subtitle: l10n.connectSubtitle,
          ),
          SizedBox(height: compact ? 14 : 18),
          InfoCard(
            title: l10n.airplayDevicePicker,
            icon: Icons.airplay_rounded,
            children: [
              Text(
                l10n.tapAirplayToChoose,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.secondaryText,
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: AirPlayRoutePicker(width: 52, height: 52)),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          InfoCard(
            title: l10n.sameWifiNetwork,
            icon: Icons.wifi_rounded,
            children: [
              Text(
                l10n.sameWifiBody,
                style: TextStyle(fontSize: 14, height: 1.5, color: context.secondaryText),
              ),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          InfoCard(
            title: l10n.airplayEnabled,
            icon: Icons.tv_rounded,
            children: [
              Text(
                l10n.airplayEnabledBody,
                style: TextStyle(fontSize: 14, height: 1.5, color: context.secondaryText),
              ),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          InfoCard(
            title: l10n.disableVpn,
            icon: Icons.vpn_key_off_rounded,
            children: [
              Text(
                l10n.disableVpnBody,
                style: TextStyle(fontSize: 14, height: 1.5, color: context.secondaryText),
              ),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          InfoCard(
            title: l10n.restartTvRouter,
            icon: Icons.refresh_rounded,
            children: [
              Text(
                l10n.restartTvRouterBody,
                style: TextStyle(fontSize: 14, height: 1.5, color: context.secondaryText),
              ),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          WarningBanner(message: l10n.airplayTroubleshootNote),
          SizedBox(height: compact ? 12 : 16),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ScreenMirrorInstructionsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.screen_share_rounded),
            label: Text(l10n.screenMirroringInstructions),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'connect'),
    );
  }
}
