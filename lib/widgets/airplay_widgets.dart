import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/navigation/navigation_helper.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../l10n/l10n_extension.dart';

class AirPlayRoutePicker extends StatelessWidget {
  const AirPlayRoutePicker({
    super.key,
    this.width = 44,
    this.height = 44,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return SizedBox(
        width: width,
        height: height,
        child: Icon(Icons.airplay, color: context.secondaryText),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: UiKitView(
        viewType: 'AirPlayRoutePickerView',
        creationParams: const <String, dynamic>{},
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}

class AirPlayVideoPlayer extends StatelessWidget {
  const AirPlayVideoPlayer({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return Center(child: Text(context.l10n.iosOnlyAirplay));
    }

    return UiKitView(
      viewType: 'AirPlayVideoPlayerView',
      creationParams: <String, dynamic>{'filePath': filePath},
      creationParamsCodec: const StandardMessageCodec(),
      layoutDirection: TextDirection.ltr,
    );
  }
}

class InstructionStep extends StatelessWidget {
  const InstructionStep({
    super.key,
    required this.number,
    required this.text,
  });

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: context.primaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.children,
    this.icon,
  });

  final String title;
  final List<Widget> children;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.2 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: AppColors.accentBlue, size: 22),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: context.primaryText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class FeatureAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeatureAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
  });

  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? context.screenBackground,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: context.primaryText,
        ),
        onPressed: () => NavigationHelper.popWithInterstitial(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: context.primaryText,
        ),
      ),
      actions: actions,
    );
  }
}
