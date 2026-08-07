import 'package:flutter/material.dart';

/// Shared navigation helpers.
abstract final class NavigationHelper {
  static Future<void> pop(BuildContext context) async {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
