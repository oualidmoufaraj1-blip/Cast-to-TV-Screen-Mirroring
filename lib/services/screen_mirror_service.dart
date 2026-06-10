import 'dart:io';

import 'package:flutter/services.dart';

class ScreenMirrorService {
  ScreenMirrorService._();

  static const _channel = MethodChannel('com.casttotv.screen_mirroring/mirror');

  static bool get isSupported => Platform.isIOS;

  static Future<bool> isAirPlayMirrorActive() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('isAirPlayMirrorActive') ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isWifiMirrorActive() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('isWifiMirrorActive') ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<String?> startWifiMirror() async {
    if (!isSupported) return null;
    try {
      final result = await _channel.invokeMethod<Map<Object?, Object?>>(
        'startWifiMirror',
      );
      return result?['url'] as String?;
    } on PlatformException {
      rethrow;
    }
  }

  static Future<void> stopWifiMirror() async {
    if (!isSupported) return;
    try {
      await _channel.invokeMethod<void>('stopWifiMirror');
    } catch (_) {}
  }

  static Future<String?> getWifiMirrorUrl() async {
    if (!isSupported) return null;
    try {
      return await _channel.invokeMethod<String>('getWifiMirrorUrl');
    } catch (_) {
      return null;
    }
  }
}
