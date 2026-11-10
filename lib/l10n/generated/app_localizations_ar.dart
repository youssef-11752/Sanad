// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سند';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get counterMessage => 'عدد مرات الضغط على الزر:';

  @override
  String get increment => 'زيادة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'الإنجليزية';
}
