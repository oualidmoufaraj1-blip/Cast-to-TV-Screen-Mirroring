import 'package:flutter/material.dart';

/// Banner slot. Ads are disabled; this always collapses to zero height so
/// review and production layouts match.
class BannerAdBar extends StatelessWidget {
  const BannerAdBar({super.key, required this.placement});

  final String placement;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
