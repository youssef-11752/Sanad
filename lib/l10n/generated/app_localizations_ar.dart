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
  String get appName => 'سَنَد';

  @override
  String get splashTagline => 'كل صنعة، لها سَنَد.';

  @override
  String get splashFooter => 'سَنَد لكل بيت';

  @override
  String get phoneNumber => 'رقم الموبايل';

  @override
  String get nationalId => 'الرقم القومي';

  @override
  String get email => 'الإيميل';

  @override
  String get password => 'كلمة المرور';

  @override
  String get fullName => 'الاسم بالكامل';

  @override
  String get city => 'المدينة';

  @override
  String get area => 'المنطقة';

  @override
  String get loginTitle => 'نورت سَنَد من جديد.';

  @override
  String get loginSubtitle => 'ادخل لحسابك، وخلّي الباقي علينا 😏 .';

  @override
  String get forgotPasswordLink => 'نسيت كلمة المرور؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get dataSecurityNote =>
      'بياناتك بأمان. رقمك وعنوانك لا يظهران إلا للمتخصص بعد تأكيد الزيارة.';

  @override
  String get firstTimeHere => '  أول مرة معانا؟';

  @override
  String get createNewAccount => 'إنشاء حساب جديد ';

  @override
  String get termsAgreementNote =>
      'بالمتابعة، أنت توافق على سياسة الخدمة والخصوصية.';

  @override
  String get registerTitle => 'حساب جديد';

  @override
  String get registerSubtitle => 'أهلاً بيك في دايرة سَنَد';

  @override
  String get passwordHint => '٨ أحرف على الأقل، تشمل حرفًا ورقمًا.';

  @override
  String get agreeToPrivacyAndTerms => 'أوافق على سياسة الخصوصية وشروط الخدمة';

  @override
  String get createAccountButton => 'إنشاء حساب';

  @override
  String get haveAccount => 'عندك حساب؟';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get enterYourEmail => 'ادخل الايميل';

  @override
  String get sendOtpButton => 'إرسال رقم سري';

  @override
  String get verifyOtpButton => 'تحقق من الرقم السري';

  @override
  String get otpTitle => 'إدخال رقمك';

  @override
  String get otpMessage =>
      'لقد أرسلنا رمز تأكيد مكونًا من 6 أرقام اليك  تأكد من إدخال الرمز الصحيح.';

  @override
  String get otpResendButton => 'إعادة إرسال الرمز';

  @override
  String get newPasswordTitle => 'كلمة مرور جديدة';

  @override
  String get enterNewPassword => 'برجاء إدخال كلمة مرور جديدة';

  @override
  String get confirmPassword => 'إعادة إدخال كلمة المرور';

  @override
  String get doneButton => 'تم';

  @override
  String get passwordResetSuccessPrefix => 'تم تجديد كلمة المرور بنجاح برجاء ';

  @override
  String get passwordResetSuccessAction => 'تسجيل الدخول';

  @override
  String get goToLoginButton => 'الذهاب الى تسجيل الدخول';

  @override
  String get hintFullName => 'مثال: مريم حسن';

  @override
  String get hintPhone => '01135045965';

  @override
  String get hintNationalId => '14 رقم';

  @override
  String get hintEmail => 'example@gmail.com';

  @override
  String get hintCity => 'اختار المدينة';

  @override
  String get hintArea => 'اختار المنطقة';

  @override
  String get hintPassword => 'ادخل كلمة المرور';

  @override
  String get hintConfirmPassword => 'أعد إدخال كلمة المرور';

  @override
  String get hintOtp => 'ادخل الرمز';

  @override
  String get errorFieldRequired => 'هذا الحقل مطلوب';

  @override
  String get errorInvalidPhone => 'رقم الموبايل غير صحيح';

  @override
  String get errorInvalidNationalId => 'الرقم القومي غير صحيح';

  @override
  String get errorInvalidEmail => 'الإيميل غير صحيح';

  @override
  String get errorPasswordTooShort => 'كلمة المرور يجب ألا تقل عن ٨ أحرف';

  @override
  String get errorPasswordWeak => 'كلمة المرور يجب أن تشمل حرفًا ورقمًا';

  @override
  String get errorPasswordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get errorInvalidOtp => 'الرمز غير صحيح';

  @override
  String get errorMustAgreeTerms =>
      'يجب الموافقة على سياسة الخصوصية وشروط الخدمة';
}
