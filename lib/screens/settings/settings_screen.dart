import 'package:flutter/material.dart';

import '../../core/navigation/navigation_helper.dart';
import '../../core/app/app_controller.dart';
import '../../core/navigation/feature_actions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../l10n/l10n_extension.dart';
import '../../services/app_info_service.dart';
import '../../services/haptic_service.dart';
import '../../services/locale_service.dart';
import '../../services/preferences_service.dart';
import '../../services/settings_actions_service.dart';
import '../../services/theme_service.dart';
import '../../widgets/banner_ad_bar.dart';
import '../../widgets/shared_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _vibrateEnabled = true;
  final _actions = FeatureActions();

  @override
  void initState() {
    super.initState();
    _vibrateEnabled = PreferencesService.instance.isVibrateEnabled;
  }

  Future<void> _setVibrateEnabled(bool value) async {
    await PreferencesService.instance.setVibrateEnabled(value);
    if (value) {
      await HapticService.lightImpact();
    }
    setState(() => _vibrateEnabled = value);
  }

  void _showLanguagePicker() {
    final l10n = context.l10n;
    final current = AppController.instance.locale.languageCode;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.language,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: sheetContext.primaryText,
                  ),
                ),
              ),
              for (final locale in LocaleService.supportedLocales)
                ListTile(
                  title: Text(
                    LocaleService.languageLabelForLocale(locale),
                    style: TextStyle(color: sheetContext.primaryText),
                  ),
                  trailing: current == locale.languageCode
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.accentBlue,
                        )
                      : null,
                  onTap: () async {
                    await HapticService.selectionClick();
                    await AppController.instance.setLocale(locale);
                    if (sheetContext.mounted) Navigator.pop(sheetContext);
                    if (mounted) setState(() {});
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showAppearancePicker() {
    final l10n = context.l10n;
    final current = ThemeService.savedAppearance;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        Widget tile(String label, AppAppearance appearance, ThemeMode mode) {
          return ListTile(
            title: Text(
              label,
              style: TextStyle(color: sheetContext.primaryText),
            ),
            trailing: current == appearance
                ? const Icon(Icons.check_rounded, color: AppColors.accentBlue)
                : null,
            onTap: () async {
              await HapticService.selectionClick();
              await AppController.instance.setThemeMode(mode);
              if (sheetContext.mounted) Navigator.pop(sheetContext);
              if (mounted) setState(() {});
            },
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.appearance,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: sheetContext.primaryText,
                  ),
                ),
              ),
              tile(l10n.systemDefault, AppAppearance.system, ThemeMode.system),
              tile(l10n.lightMode, AppAppearance.light, ThemeMode.light),
              tile(l10n.darkMode, AppAppearance.dark, ThemeMode.dark),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  String _appearanceLabel() {
    final l10n = context.l10n;
    return switch (ThemeService.savedAppearance) {
      AppAppearance.light => l10n.lightMode,
      AppAppearance.dark => l10n.darkMode,
      AppAppearance.system => l10n.systemDefault,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final compact = Responsive.isCompact(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: context.settingsBackground,
      appBar: AppBar(
        backgroundColor: context.settingsBackground,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: context.primaryText,
          ),
          onPressed: () => NavigationHelper.popWithInterstitial(context),
        ),
        title: Text(
          l10n.settings,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: context.primaryText,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(padding, 8, padding, 32),
        children: [
          SettingsSectionCard(
            title: l10n.general,
            children: [
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.translate_rounded,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.language,
                onTap: _showLanguagePicker,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleService.languageLabelForLocale(
                        AppController.instance.locale,
                      ),
                      style: const TextStyle(
                        color: AppColors.accentBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: context.secondaryText,
                      size: 22,
                    ),
                  ],
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.dark_mode_outlined,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.appearance,
                onTap: _showAppearancePicker,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _appearanceLabel(),
                      style: const TextStyle(
                        color: AppColors.accentBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: context.secondaryText,
                      size: 22,
                    ),
                  ],
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.vibration_rounded,
                  color: Color(0xFFFF9500),
                ),
                iconColor: const Color(0xFFFF9500),
                title: l10n.vibrateFeedback,
                showDivider: false,
                trailing: Switch(
                  value: _vibrateEnabled,
                  onChanged: _setVibrateEnabled,
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 16 : 20),
          SettingsSectionCard(
            title: l10n.howToUse,
            children: [
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.wifi_rounded,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.connectToTv,
                onTap: () => _actions.openConnect(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.cast_rounded,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.castConnectionGuide,
                onTap: () => _actions.openCastConnectionGuide(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.screen_share_rounded,
                  color: Color(0xFFFF9500),
                ),
                iconColor: const Color(0xFFFF9500),
                title: l10n.screenMirror,
                onTap: () => _actions.openScreenMirror(context),
                showDivider: false,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 16 : 20),
          SettingsSectionCard(
            title: l10n.moreSettings,
            children: [
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.star_rounded,
                  color: Color(0xFFFF9500),
                ),
                iconColor: const Color(0xFFFF9500),
                title: l10n.giveUsFiveStar,
                onTap: () => SettingsActionsService.rateApp(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.chat_bubble_outline_rounded,
                  color: Color(0xFFFF2D55),
                ),
                iconColor: const Color(0xFFFF2D55),
                title: l10n.contactUs,
                onTap: () => SettingsActionsService.contactUs(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.share_rounded,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.shareApp,
                onTap: () => SettingsActionsService.shareApp(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.shield_rounded,
                  color: Color(0xFFAF52DE),
                ),
                iconColor: const Color(0xFFAF52DE),
                title: l10n.privacyPolicy,
                onTap: () => SettingsActionsService.openPrivacyPolicy(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.description_outlined,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.termsOfUse,
                onTap: () => SettingsActionsService.openTermsOfUse(context),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.secondaryText,
                  size: 22,
                ),
              ),
              SettingsTile(
                icon: const CircleIcon(
                  icon: Icons.info_outline_rounded,
                  color: AppColors.accentBlue,
                ),
                iconColor: AppColors.accentBlue,
                title: l10n.versionLabel(AppInfoService.version),
                showDivider: false,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdBar(placement: 'settings'),
    );
  }
}
