// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sanad';

  @override
  String get homeTitle => 'Sanad home';

  @override
  String get counterMessage => 'You have pushed the button this many times:';

  @override
  String get increment => 'Increment';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';
}
