import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../services/app_open_ad_service.dart';
import '../../services/preferences_service.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    unawaited(_navigateNext());
  }

  Future<void> _navigateNext() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final completed = PreferencesService.instance.isOnboardingCompleted;

    // First launch: skip app open ad for better UX and App Store safety.
    if (completed) {
      await AppOpenAdService.showOnLaunchIfAvailable(
        onboardingCompleted: true,
      );
    }
    if (!mounted) return;

    final nextScreen = completed ? HomeScreen() : const OnboardingScreen();

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBlue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
