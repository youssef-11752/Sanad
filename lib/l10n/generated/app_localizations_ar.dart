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

  @override
  String get categoriesTitle => 'كل الأقسام';

  @override
  String get categoriesSubtitle => 'اختار الخدمة المناسبة لك';

  @override
  String get homeServicesLabel => 'خدمات المنزل';

  @override
  String get categoriesSearchHint => 'ابحث عن خدمة أو عطل';

  @override
  String get categoriesNoResults => 'مفيش أقسام مطابقة لبحثك';

  @override
  String get navigationComingSoon => 'القسم ده هيتاح قريبًا';

  @override
  String categoryComingSoon(String category) {
    return 'خدمات $category هتكون متاحة قريبًا';
  }

  @override
  String get applianceCategory => 'صيانة الأجهزة المنزلية';

  @override
  String get applianceCategoryDescription =>
      'صيانة وإصلاح جميع الأجهزة المنزلية';

  @override
  String get paintingCategory => 'النقاشة';

  @override
  String get paintingCategoryDescription => 'دهان وديكورات وتجديد الحوائط';

  @override
  String get carpentryCategory => 'النجارة';

  @override
  String get carpentryCategoryDescription =>
      'أعمال صيانة ونجارة الأثاث المنزلي';

  @override
  String get electricalCategory => 'الكهرباء';

  @override
  String get electricalCategoryDescription => 'كهرباء وإنارة ومفاتيح ولوحات';

  @override
  String get airConditioningCategory => 'صيانة المكيفات';

  @override
  String get airConditioningCategoryDescription => 'صيانة وتركيب مكيفات الهواء';

  @override
  String get plumbingCategory => 'السباكة';

  @override
  String get plumbingCategoryDescription => 'إصلاح تسريبات وتركيب المواسير';
}
