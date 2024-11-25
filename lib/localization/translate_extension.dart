import 'package:flutter/material.dart';

import 'app_localization.dart';
import 'constants.dart';
import 'localization_controller.dart';
import 'localization_utils.dart';

class TrNameSpaces {
  final bool isPro;

  TrNameSpaces({
    this.isPro = false,
  });

  String? get name {
    if (isPro) {
      return LocalizationConstants.proPrefix;
    }
    return null;
  }
}

extension LocalizationExtension on BuildContext {
  AppLocale get appLocale => AppLocalization.of(this)!.appLocale;

  List<Locale> get supportedLocales => AppLocalization.of(this)!.supportedLocales;

  List<LocalizationsDelegate> get localizationDelegates => AppLocalization.of(this)!.delegates;

  Future<void> setLocale(AppLocale value) async => AppLocalization.of(this)!.setLocale(value);
}

extension TranslateExtension on String {
  String tr({
    List<String>? args,
    Map<String, String>? namedArgs,
    String? prefix,
  }) {
    return LocalizationUtils.instance.tr(
      this,
      args: args,
      namedArgs: namedArgs,
      prefix: prefix,
    );
  }
}
