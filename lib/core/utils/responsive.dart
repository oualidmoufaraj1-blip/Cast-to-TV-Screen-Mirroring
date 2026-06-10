import 'package:flutter/material.dart';

class Responsive {
  static bool isCompact(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 375;
  }

  static double horizontalPadding(BuildContext context) {
    return isCompact(context) ? 16 : 20;
  }

  static double titleSize(BuildContext context) {
    return isCompact(context) ? 18 : 20;
  }

  static double sectionTitleSize(BuildContext context) {
    return isCompact(context) ? 16 : 18;
  }

  static double cardTitleSize(BuildContext context) {
    return isCompact(context) ? 20 : 22;
  }

  static double featureCardHeight(BuildContext context) {
    return isCompact(context) ? 108 : 120;
  }

  static double headerHeight(BuildContext context) {
    return isCompact(context) ? 168 : 188;
  }

  static double gridAspectRatio(BuildContext context) {
    return isCompact(context) ? 1.25 : 1.35;
  }
}
