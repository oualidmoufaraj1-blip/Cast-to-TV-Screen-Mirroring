import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/fullscreen_ad_service.dart';
import '../../services/haptic_service.dart';
import '../../services/preferences_service.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    this.markCompleteOnFinish = true,
  });

  final bool markCompleteOnFinish;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _pageIcons = [
    Icons.photo_library_rounded,
    Icons.wifi_rounded,
    Icons.screen_share_rounded,
  ];

  (String title, String body) _pageContent(BuildContext context, int index) {
    final l10n = context.l10n;
    return switch (index) {
      0 => (l10n.onboarding1Title, l10n.onboarding1Body),
      1 => (l10n.onboarding2Title, l10n.onboarding2Body),
      _ => (l10n.onboarding3Title, l10n.onboarding3Body),
    };
  }

  Future<void> _finish({required bool skipped}) async {
    await HapticService.mediumImpact();
    await FullScreenAdService.showRewarded();
    if (!mounted) return;

    if (widget.markCompleteOnFinish) {
      await PreferencesService.instance.setOnboardingCompleted(true);
    }
    if (!mounted) return;

    if (widget.markCompleteOnFinish) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _next() async {
    await HapticService.selectionClick();
    if (_currentPage < _pageIcons.length - 1) {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }
    await _finish(skipped: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);
    final isLastPage = _currentPage == _pageIcons.length - 1;

    return Scaffold(
      backgroundColor: context.screenBackground,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _finish(skipped: true),
                child: Text(l10n.skip),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pageIcons.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final (title, body) = _pageContent(context, index);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: compact ? 88 : 100,
                          height: compact ? 88 : 100,
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _pageIcons[index],
                            size: compact ? 40 : 46,
                            color: AppColors.accentBlue,
                          ),
                        ),
                        SizedBox(height: compact ? 24 : 32),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: compact ? 24 : 28,
                            fontWeight: FontWeight.w700,
                            color: context.primaryText,
                          ),
                        ),
                        SizedBox(height: compact ? 12 : 16),
                        Text(
                          body,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: compact ? 14 : 16,
                            height: 1.5,
                            color: context.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pageIcons.length, (index) {
                final active = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.accentBlue
                        : (context.isDark ? const Color(0xFF3A3A3C) : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padding, compact ? 16 : 24, padding, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _next,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    minimumSize: Size.fromHeight(compact ? 46 : 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isLastPage ? l10n.getStarted : l10n.next,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
