import 'package:flutter/material.dart';
import 'package:edulab_b2b/l10n/gen/app_localizations.dart';
import 'package:edulab_b2b/l10n/gen/app_localizations_en.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get localizations =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}
