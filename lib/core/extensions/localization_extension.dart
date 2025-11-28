import 'package:flutter/material.dart';
import 'package:leti_mobile/l10n/gen/app_localizations.dart';
import 'package:leti_mobile/l10n/gen/app_localizations_en.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get localizations =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}
