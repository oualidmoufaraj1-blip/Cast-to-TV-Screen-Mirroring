import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  AppInfoService._();

  static PackageInfo? _packageInfo;

  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get version {
    final info = _packageInfo;
    if (info == null) return '1.0.0';
    return info.version;
  }

  static String get buildNumber {
    final info = _packageInfo;
    if (info == null) return '1';
    return info.buildNumber;
  }

  static String get versionLabel => '$version ($buildNumber)';
}
