import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/gen/l10n/app_localizations.dart';

extension AppLocalizationExtension on AppLocalizations{
  String getLanguageName(String languageCode) {
    return switch (languageCode) {
      'en' => english,
      'bn' => bangla,
      'ar' => arabic,
      _ => languageCode,
    };
  }
}

extension BuildContextLocalizationExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}
