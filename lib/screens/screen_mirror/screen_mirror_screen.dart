import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/haptic_service.dart';
import '../../services/screen_mirror_service.dart';
import '../../widgets/airplay_widgets.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/empty_state.dart';
import 'screen_mirror_instructions_screen.dart';

class ScreenMirrorScreen extends StatefulWidget {
  const ScreenMirrorScreen({super.key});

  @override
  State<ScreenMirrorScreen> createState() => _ScreenMirrorScreenState();
}

class _ScreenMirrorScreenState extends State<ScreenMirrorScreen> {
  bool _airPlayActive = false;
  bool _wifiMirrorActive = false;
  bool _isStarting = false;
  String? _mirrorUrl;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _refreshStatus();
  }

  @override
  void dispose() {
    if (_wifiMirrorActive) {
      ScreenMirrorService.stopWifiMirror();
    }
    super.dispose();
  }

  Future<void> _refreshStatus() async {
    final airPlay = await ScreenMirrorService.isAirPlayMirrorActive();
    final wifi = await ScreenMirrorService.isWifiMirrorActive();
    if (!mounted) return;
    setState(() {
      _airPlayActive = airPlay;
      _wifiMirrorActive = wifi;
      if (wifi) {
        _mirrorUrl ??= null;
      }
    });
    if (wifi) {
      final url = await ScreenMirrorService.getWifiMirrorUrl();
      if (mounted && url != null) {
        setState(() => _mirrorUrl = url);
      }
    }
  }

  Future<void> _toggleWifiMirror() async {
    if (_wifiMirrorActive) {
      await ScreenMirrorService.stopWifiMirror();
      await HapticService.lightImpact();
      setState(() {
        _wifiMirrorActive = false;
        _mirrorUrl = null;
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isStarting = true;
      _errorMessage = null;
    });

    try {
      final url = await ScreenMirrorService.startWifiMirror();
      await HapticService.mediumImpact();
      if (!mounted) return;
      setState(() {
        _isStarting = false;
        _wifiMirrorActive = url != null;
        _mirrorUrl = url;
      });
    } on PlatformException catch (_) {
      if (!mounted) return;
      setState(() {
        _isStarting = false;
        _errorMessage = context.l10n.mirrorStartFailed;
      });
    }
  }

  Future<void> _copyUrl() async {
    final url = _mirrorUrl;
    if (url == null) return;
    await Clipboard.setData(ClipboardData(text: url));
    await HapticService.lightImpact();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.mirrorUrlCopied)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      appBar: FeatureAppBar(title: l10n.screenMirror),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          padding,
          8,
          padding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(compact ? 16 : 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.screenMirrorStart, AppColors.screenMirrorEnd],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.screen_share_rounded, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  l10n.mirroringUsesControlCenter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.mirroringBannerBody,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 14 : 18),
          InfoCard(
            title: l10n.wifiTvMirror,
            icon: Icons.cast_connected_rounded,
            children: [
              Text(
                l10n.wifiTvMirrorBody,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.secondaryText,
                ),
              ),
              SizedBox(height: compact ? 12 : 16),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              FilledButton.icon(
                onPressed: _isStarting ? null : _toggleWifiMirror,
                icon: _isStarting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(_wifiMirrorActive ? Icons.stop_rounded : Icons.play_arrow_rounded),
                label: Text(
                  _wifiMirrorActive ? l10n.stopMirroring : l10n.startMirroring,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accentBlue,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              if (_mirrorUrl != null) ...[
                const SizedBox(height: 14),
                Text(
                  l10n.mirrorUrlLabel,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.isDark
                        ? const Color(0xFF2C2C2E)
                        : const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    _mirrorUrl!,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _copyUrl,
                  icon: const Icon(Icons.copy_rounded),
                  label: Text(l10n.copyMirrorUrl),
                ),
              ],
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          InfoCard(
            title: l10n.airPlayMirrorSection,
            icon: Icons.airplay_rounded,
            children: [
              Row(
                children: [
                  Icon(
                    _airPlayActive ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    color: _airPlayActive ? const Color(0xFF34C759) : context.secondaryText,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.airPlayMirrorStatus,
                          style: TextStyle(
                            fontSize: 13,
                            color: context.secondaryText,
                          ),
                        ),
                        Text(
                          _airPlayActive ? l10n.airPlayMirrorActive : l10n.airPlayMirrorInactive,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: context.primaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _refreshStatus,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.refreshStatus),
              ),
              const SizedBox(height: 14),
              InstructionStep(number: 1, text: l10n.step1Body),
              InstructionStep(number: 2, text: l10n.step2Body),
              InstructionStep(number: 3, text: l10n.step3Body),
            ],
          ),
          SizedBox(height: compact ? 10 : 12),
          InfoCard(
            title: l10n.step(4),
            icon: Icons.stop_circle_outlined,
            children: [
              Text(
                l10n.step4Body,
                style: TextStyle(fontSize: 14, height: 1.5, color: context.secondaryText),
              ),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          WarningBanner(message: l10n.mirroringWarning),
          SizedBox(height: compact ? 12 : 16),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ScreenMirrorInstructionsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.menu_book_rounded),
            label: Text(l10n.viewDetailedInstructions),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accentBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'mirror'),
    );
  }
}
