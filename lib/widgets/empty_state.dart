import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/responsive.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final compact = Responsive.isCompact(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(compact ? 20 : 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: compact ? 64 : 72,
              height: compact ? 64 : 72,
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: compact ? 30 : 34, color: AppColors.accentBlue),
            ),
            SizedBox(height: compact ? 14 : 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: compact ? 17 : 18,
                fontWeight: FontWeight.w700,
                color: context.primaryText,
              ),
            ),
            SizedBox(height: compact ? 8 : 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: compact ? 13 : 14,
                height: 1.5,
                color: context.secondaryText,
              ),
            ),
            if (action != null) ...[
              SizedBox(height: compact ? 18 : 22),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class WarningBanner extends StatelessWidget {
  const WarningBanner({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF3A3200) : const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF665500) : const Color(0xFFFFE08A),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: isDark ? const Color(0xFFFFD54F) : const Color(0xFF856404),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: isDark ? const Color(0xFFFFE08A) : const Color(0xFF856404),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final compact = Responsive.isCompact(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: compact ? 22 : 24,
            fontWeight: FontWeight.w700,
            color: context.primaryText,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: compact ? 6 : 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: compact ? 13 : 14,
              height: 1.45,
              color: context.secondaryText,
            ),
          ),
        ],
      ],
    );
  }
}

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 8),
        ],
        Text(label),
      ],
    );

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: child,
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accentBlue,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: child,
    );
  }
}
