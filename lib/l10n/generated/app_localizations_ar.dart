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
  String get currentRequestsTab => 'الجارية (١)';

  @override
  String get pastRequestsTab => 'السابقة (٣)';

  @override
  String get currentOrdersSection => 'الطلبات الجارية';

  @override
  String get pastVisitsSection => 'من زياراتك السابقة';

  @override
  String get scheduledVisitStatus => 'زيارة محجوزة';

  @override
  String get currentServiceTitle => 'إصلاح غسالة أوتوماتيك';

  @override
  String get currentProviderInfo => 'أحمد سيد • مدينة نصر';

  @override
  String get currentVisitDate => 'الأحد ٧ نوفمبر • ١–٢ مساءً';

  @override
  String trackRequestButton(String requestId) {
    return 'متابعة $requestId';
  }

  @override
  String trackRequestComingSoon(String requestId) {
    return 'تفاصيل الطلب $requestId قريبًا';
  }

  @override
  String get completedStatus => 'مكتمل';

  @override
  String get completedRatedStatus => 'مكتمل وتم التقييم';

  @override
  String get cancelledStatus => 'ملغي';

  @override
  String get pastRepairTitle => 'إصلاح تسريب حوض المطبخ';

  @override
  String get pastRepairProvider => 'حسام عادل • المعادي';

  @override
  String get pastRepairDate => '٢٨ أكتوبر ٢٠٢٦ • ٤:٣٠ مساءً';

  @override
  String get pastFridgeTitle => 'صيانة ثلاجة';

  @override
  String get pastFridgeProvider => 'أحمد سيد • مدينة نصر';

  @override
  String get pastFridgeDate => '١٥ سبتمبر ٢٠٢٦ • ٣ مساءً';

  @override
  String get pastLightTitle => 'تركيب وحدة إضاءة';

  @override
  String get pastLightProvider => 'إبراهيم • مدينة نصر';

  @override
  String get pastLightDate => '١ سبتمبر ٢٠٢٦';

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
