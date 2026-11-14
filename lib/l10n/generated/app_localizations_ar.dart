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

  @override
  String get requestsTitle => 'طلباتي';

  @override
  String get requestsSubtitle => 'كل بياناتك واحتياجاتك في مكان واحد';

  @override
  String currentRequestsTab(int count) {
    return 'الجارية ($count)';
  }

  @override
  String pastRequestsTab(int count) {
    return 'السابقة ($count)';
  }

  @override
  String get noCurrentOrders => 'لا توجد طلبات حالية.';

  @override
  String get noPreviousOrders => 'لا توجد طلبات سابقة.';

  @override
  String get ordersLoadError => 'تعذر تحميل طلباتك.';

  @override
  String get retryButton => 'إعادة المحاولة';

  @override
  String get currentOrdersSection => 'الطلبات الجارية';

  @override
  String get pastVisitsSection => 'من زياراتك السابقة';

  @override
  String get pendingStatus => 'قيد الانتظار';

  @override
  String get fulfilledStatus => 'تم التنفيذ';

  @override
  String get newRequestButton => 'اطلب خدمة جديدة';

  @override
  String get newRequestComingSoon => 'إنشاء طلب جديد قريبًا';

  @override
  String get homeNavigation => 'الرئيسية';

  @override
  String get categoriesNavigation => 'الأقسام';

  @override
  String get myRequestsNavigation => 'طلباتي';

  @override
  String get accountNavigation => 'حسابي';
}
