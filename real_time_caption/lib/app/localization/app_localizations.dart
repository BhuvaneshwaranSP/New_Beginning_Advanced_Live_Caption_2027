import 'package:flutter/material.dart';
import 'translations/en.dart';
import 'translations/hi.dart';
import 'translations/ml.dart';
import 'translations/ta.dart';
import 'translations/te.dart';

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  String get appName => _strings['appName'] ?? 'LinguaLive';
  String get home => _strings['home'] ?? 'Home';
  String get settings => _strings['settings'] ?? 'Settings';
  String get profile => _strings['profile'] ?? 'Profile';

  Map<String, String> get _strings {
    switch (locale.languageCode) {
      case 'ta': return ta;
      case 'te': return te;
      case 'hi': return hi;
      case 'ml': return ml;
      default: return en;
    }
  }

  static const delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => {'en', 'ta', 'te', 'hi', 'ml'}.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
