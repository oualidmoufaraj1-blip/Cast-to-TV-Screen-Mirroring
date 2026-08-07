import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app/app_controller.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'services/app_info_service.dart';
import 'services/locale_service.dart';
import 'services/preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  await AppInfoService.init();
  await AppController.instance.initialize();

  // Ads are not initialized from remote config.
  // Guideline 5.6: do not load monetization/feature gates from a mutable URL
  // (e.g. Google Drive) that can differ between App Review and production.
  // Optional local ads may be re-enabled later via a shipped asset + production
  // AdMob IDs only — never via a post-review mutable remote file.

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CastToTvApp());
}

class CastToTvApp extends StatefulWidget {
  const CastToTvApp({super.key});

  @override
  State<CastToTvApp> createState() => _CastToTvAppState();
}

class _CastToTvAppState extends State<CastToTvApp> {
  final _controller = AppController.instance;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cast To TV - Screen Mirroring',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _controller.themeMode,
      locale: _controller.locale,
      supportedLocales: LocaleService.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}
