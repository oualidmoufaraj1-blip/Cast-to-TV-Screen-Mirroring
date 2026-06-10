import 'package:flutter/widgets.dart';

import 'app_strings.dart';

extension L10nX on BuildContext {
  AppStrings get l10n => AppStrings.of(Localizations.localeOf(this));
}
