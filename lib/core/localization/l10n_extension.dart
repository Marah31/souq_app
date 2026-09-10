import 'package:flutter/material.dart';
import 'package:souq_app/l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get l10n {
    return AppLocalizations.of(this)!;
  }
  String getLocalizedCategory(String category) {
    final cleanCat = category.trim().toLowerCase();

    return switch (cleanCat) {
      'electronics' => l10n.electronics,
      'jewelery' || 'jewelry' => l10n.jewelery,
      "men's clothing" || 'mens clothing' => l10n.mensClothing,
      "women's clothing" || 'womens clothing' => l10n.womensClothing,
      _ => category.isNotEmpty
          ? category[0].toUpperCase() + category.substring(1)
          : category,
    };
  }
}