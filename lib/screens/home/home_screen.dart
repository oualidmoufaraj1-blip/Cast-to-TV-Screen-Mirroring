import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/navigation/feature_actions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/cast_icon_painter.dart';
import '../../widgets/shared_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, FeatureActions? featureActions})
      : _actions = featureActions ?? FeatureActions();

  final FeatureActions _actions;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      context.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    );
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: context.screenBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context, padding)),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _TappableCard(
                    onTap: () => _actions.openConnect(context),
                    child: _buildConnectCard(context),
                  ),
                  SizedBox(height: Responsive.isCompact(context) ? 12 : 16),
                  _TappableCard(
                    onTap: () => _actions.openScreenMirror(context),
                    child: _buildScreenMirrorCard(context),
                  ),
                  SizedBox(height: Responsive.isCompact(context) ? 10 : 12),
                  _buildSecondaryFeaturesRow(context),
                  SizedBox(height: Responsive.isCompact(context) ? 18 : 24),
                  _buildTvCastSection(context),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'home'),
    );
  }

  Widget _buildHeader(BuildContext context, double padding) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);

    return Stack(
      children: [
        Container(
          height: Responsive.headerHeight(context),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.isDark ? AppColors.darkCard : const Color(0xFFE8F4FD),
                context.screenBackground.withValues(alpha: 0),
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                right: -20,
                top: 20,
                child: Container(
                  width: compact ? 90 : 120,
                  height: compact ? 90 : 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(padding, 8, padding, 0),
          child: Column(
            children: [
              Row(
                children: [
                  AppLogo(size: compact ? 28 : 32),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.appName,
                      style: TextStyle(
                        fontSize: Responsive.titleSize(context),
                        fontWeight: FontWeight.w700,
                        color: context.primaryText,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _actions.openSettings(context),
                    icon: Icon(
                      Icons.settings_outlined,
                      size: compact ? 22 : 24,
                    ),
                    color: context.primaryText,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              SizedBox(height: compact ? 12 : 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: compact ? 0 : 8),
                child: Text(
                  l10n.wifiNotice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: compact ? 13 : 14,
                    color: context.secondaryText,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: compact ? 10 : 12),
              _HelpCard(
                onTap: () => _actions.openOnboarding(context),
                compact: compact,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnectCard(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: Responsive.isCompact(context) ? 14 : 18,
      ),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.2 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.tv_rounded, size: 36, color: Colors.grey.shade700),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 14, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.connectYourDevice,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: context.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.tapToConnect,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.accentBlue,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildScreenMirrorCard(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, compact ? 18 : 22, 16, compact ? 18 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.screenMirrorStart, AppColors.screenMirrorEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.screenMirrorStart.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.screenMirror,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.cardTitleSize(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.mirrorPhoneSubtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: compact ? 12 : 13,
                  ),
                ),
              ],
            ),
          ),
          CastIcon(
            size: compact ? 60 : 72,
            color: Colors.white,
            strokeWidth: 1.8,
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryFeaturesRow(BuildContext context) {
    final l10n = context.l10n;
    final height = Responsive.featureCardHeight(context);

    return Row(
      children: [
        Expanded(
          child: _TappableCard(
            onTap: () => _actions.openRemoteControl(context),
            child: _FeatureGradientCard(
              title: l10n.remoteControl,
              height: height,
              gradient: const [AppColors.remoteStart, AppColors.remoteEnd],
              icon: Icons.settings_remote_rounded,
            ),
          ),
        ),
        SizedBox(width: Responsive.isCompact(context) ? 10 : 12),
        Expanded(
          child: _TappableCard(
            onTap: () => _actions.openYoutube(context),
            child: _FeatureGradientCard(
              title: l10n.youtube,
              height: height,
              gradient: const [AppColors.youtubeStart, AppColors.youtubeEnd],
              icon: Icons.play_arrow_rounded,
              isYoutube: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTvCastSection(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.tvCast,
          style: TextStyle(
            fontSize: Responsive.sectionTitleSize(context),
            fontWeight: FontWeight.w700,
            color: context.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: Responsive.gridAspectRatio(context),
          children: [
            _TappableCard(
              onTap: () => _actions.openPhoto(context),
              child: _TvCastTile(
                label: l10n.photo,
                backgroundColor: AppColors.photoBg,
                iconColor: AppColors.photoIcon,
                icon: Icons.photo_outlined,
              ),
            ),
            _TappableCard(
              onTap: () => _actions.openVideo(context),
              child: _TvCastTile(
                label: l10n.video,
                backgroundColor: AppColors.videoBg,
                iconColor: AppColors.videoIcon,
                icon: Icons.videocam_outlined,
              ),
            ),
            _TappableCard(
              onTap: () => _actions.openVimeo(context),
              child: _TvCastTile(
                label: l10n.vimeo,
                backgroundColor: AppColors.vimeoBg,
                iconColor: AppColors.vimeoIcon,
                icon: Icons.play_circle_outline,
              ),
            ),
            _TappableCard(
              onTap: () => _actions.openBrowser(context),
              child: _TvCastTile(
                label: l10n.browser,
                backgroundColor: AppColors.browserBg,
                iconColor: AppColors.browserIcon,
                icon: Icons.language_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TappableCard extends StatelessWidget {
  const _TappableCard({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }
}

class _FeatureGradientCard extends StatelessWidget {
  const _FeatureGradientCard({
    required this.title,
    required this.height,
    required this.gradient,
    required this.icon,
    this.isYoutube = false,
  });

  final String title;
  final double height;
  final List<Color> gradient;
  final IconData icon;
  final bool isYoutube;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isYoutube)
            Container(
              width: 36,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.play_arrow, color: Colors.red, size: 22),
            )
          else
            Icon(icon, color: Colors.white, size: 32),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TvCastTile extends StatelessWidget {
  const _TvCastTile({
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
  });

  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final compact = Responsive.isCompact(context);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: compact ? 40 : 44,
            height: compact ? 40 : 44,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: compact ? 22 : 26),
          ),
          SizedBox(height: compact ? 8 : 10),
          Text(
            label,
            style: TextStyle(
              fontSize: compact ? 13 : 14,
              fontWeight: FontWeight.w600,
              color: context.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard({
    required this.onTap,
    required this.compact,
  });

  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12 : 14,
            vertical: compact ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.accentBlue.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: compact ? 34 : 38,
                height: compact ? 34 : 38,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.help_outline_rounded,
                  size: compact ? 18 : 20,
                  color: AppColors.accentBlue,
                ),
              ),
              SizedBox(width: compact ? 10 : 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.howItWorks,
                      style: TextStyle(
                        fontSize: compact ? 14 : 15,
                        fontWeight: FontWeight.w700,
                        color: context.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.helpSubtitle,
                      style: TextStyle(
                        fontSize: compact ? 12 : 13,
                        color: context.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.accentBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
