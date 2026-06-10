import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:multiads/multiads.dart';

import 'core/app/app_controller.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'services/app_info_service.dart';
import 'services/app_open_ad_service.dart';
import 'services/consent_service.dart';
import 'services/locale_service.dart';
import 'services/preferences_service.dart';
import 'util/global.dart';

const _adsConfigUrl =
    'https://drive.google.com/uc?export=download&id=1E79DeZvNv-XDcSMxydzTWiUTGoBF-i_8';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  await AppInfoService.init();
  await AppController.instance.initialize();
  await ConsentService.requestConsent();
  await _initAds();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  AppOpenAdService.markColdStart();
  runApp(const CastToTvApp());
}

Future<void> _initAds() async {
  try {
    final response = await http.get(Uri.parse(_adsConfigUrl));
    if (response.statusCode != 200) return;

    gAds = MultiAds(
      response.body,
      config: const MultiAdsConfig(
        admobTestDeviceIds: ['79738754EC81FA5F64972928128B2FFF'],
        facebookTestingId: 'd1a0df1f-2528-4e41-a4d3-1b401ba14f7d',
        enableLogs: true,
      ),
    );
    gAdsReady = true;
    await gAds.init();
    await gAds.loadAds();
  } catch (_) {
    // Ads config unavailable; app still launches without ads.
  }
}

class CastToTvApp extends StatefulWidget {
  const CastToTvApp({super.key});

  @override
  State<CastToTvApp> createState() => _CastToTvAppState();
}

class _CastToTvAppState extends State<CastToTvApp> with WidgetsBindingObserver {
  final _controller = AppController.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onChanged);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        AppOpenAdService.onAppBackgrounded();
      case AppLifecycleState.resumed:
        AppOpenAdService.onAppResumed();
      case AppLifecycleState.inactive:
        break;
    }
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cast to TV: Screen Mirroring',
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
