import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accentBlue,
        brightness: Brightness.light,
        surface: AppColors.cardWhite,
      ),
      cardColor: AppColors.cardWhite,
      dividerColor: Colors.grey.withValues(alpha: 0.15),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
        centerTitle: false,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentBlue;
          }
          return const Color(0xFFE5E5EA);
        }),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accentBlue,
        brightness: Brightness.dark,
        surface: AppColors.darkCard,
      ),
      cardColor: AppColors.darkCard,
      dividerColor: Colors.white.withValues(alpha: 0.08),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.darkTextPrimary,
        centerTitle: false,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentBlue;
          }
          return const Color(0xFF3A3A3C);
        }),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension AppThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get primaryText =>
      isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

  Color get secondaryText =>
      isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

  Color get cardColor => isDark ? AppColors.darkCard : AppColors.cardWhite;

  Color get screenBackground =>
      isDark ? AppColors.darkBackground : AppColors.background;

  Color get settingsBackground =>
      isDark ? AppColors.darkBackground : AppColors.settingsBackground;
}
