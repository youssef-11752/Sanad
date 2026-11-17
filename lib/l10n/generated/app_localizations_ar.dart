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
  String get backNavigation => 'رجوع';

  @override
  String get deleteRequestTooltip => 'حذف الطلب';

  @override
  String get deleteRequestTitle => 'حذف الطلب';

  @override
  String get deleteRequestConfirmation =>
      'متأكد إنك عايز تحذف الطلب؟ لا يمكن التراجع عن الحذف.';

  @override
  String get deleteButton => 'حذف';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get requestDeletedMessage => 'تم حذف الطلب.';

  @override
  String get requestDeleteError => 'تعذر حذف الطلب. ربما تم إسناده لمقدم خدمة.';

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
  String get homeSearchNoResults => 'مفيش خدمات مطابقة لبحثك';

  @override
  String get allRequestsLink => 'كل الطلبات';

  @override
  String get homeAddressTitle => 'عنوان الخدمة';

  @override
  String get homeBannerEyebrow => 'سند يقرّب لك أهل الصنعة';

  @override
  String get homeBannerTitle => 'لكل مشكلة، متخصص يساعدك';

  @override
  String get homeBannerDescription => 'متخصصون موثوقون لجميع خدمات منزلك';

  @override
  String get homeRequestServiceButton => 'اطلب خدمة الآن';

  @override
  String get homeServicePrompt => 'محتاج خدمة إيه النهارده؟';

  @override
  String get homeRecommendedProviders => 'مقدمو خدمات موصى بهم';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get homeProviderSpecialty => 'متخصص في صيانة الأجهزة المنزلية';

  @override
  String get homeResponseTime => 'متاح خلال 30 دقيقة';

  @override
  String providerRating(String rating, int count) {
    return '$rating ($count تقييم)';
  }

  @override
  String providerExperience(int years) {
    return 'خبرة $years سنوات';
  }

  @override
  String get providerAvailableToday => 'متاح اليوم';

  @override
  String get providerAvailableTomorrow => 'متاح غدًا';

  @override
  String providerVisitPrice(int price) {
    return '$price ج.م للزيارة';
  }

  @override
  String get newRequestTitle => 'طلب خدمة جديدة';

  @override
  String get requestCategoryLabel => 'نوع الخدمة';

  @override
  String get requestCityLabel => 'المدينة';

  @override
  String get requestTitleLabel => 'عنوان الطلب';

  @override
  String get requestDetailsLabel => 'تفاصيل المشكلة';

  @override
  String get requestAddressLabel => 'العنوان بالتفصيل';

  @override
  String get chooseRequestCategory => 'اختار نوع الخدمة';

  @override
  String get chooseRequestCity => 'اختار المدينة';

  @override
  String get requestSubmitButton => 'إرسال الطلب';

  @override
  String get requestOptionsError => 'تعذر تحميل الخدمات والمدن.';

  @override
  String get requestCreateError => 'تعذر إنشاء الطلب.';

  @override
  String get requestCreatedMessage => 'تم إرسال طلبك بنجاح.';

  @override
  String get requestNoCategories =>
      'مفيش أقسام متاحة؛ تأكد من وجودها والسماح بقراءتها في Supabase.';

  @override
  String get requestNoCities =>
      'مفيش مدن متاحة؛ تأكد من وجودها والسماح بقراءتها في Supabase.';

  @override
  String get navigationComingSoon => 'القسم ده هيتاح قريبًا';

  @override
  String get profileSettingsTitle => 'حسابي والإعدادات';

  @override
  String get accountProvider => 'حساب مقدم خدمة';

  @override
  String get accountCustomer => 'حساب عميل';

  @override
  String get yourAccount => 'حسابك';

  @override
  String get personalProfile => 'الملف الشخصي';

  @override
  String get personalProfileSubtitle => 'الاسم ورقم الموبايل وبياناتك';

  @override
  String get profileWelcome => 'أهلاً بيك في دائرة سند';

  @override
  String get fullNameLabel => 'الاسم بالكامل';

  @override
  String get phoneNumberLabel => 'رقم الموبايل';

  @override
  String get cityLabel => 'المدينة';

  @override
  String get districtLabel => 'المنطقة';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get profilePasswordHint => '٨ أحرف على الأقل، تشمل حرفًا ورقمًا.';

  @override
  String get profileOkay => 'حسنًا، فهمت';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get saveProfile => 'حفظ التعديلات';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get invalidPhoneNumber => 'أدخل رقم هاتف صحيحًا';

  @override
  String get profileSaved => 'تم تحديث بيانات الملف الشخصي';

  @override
  String get profileSaveError => 'تعذر حفظ بيانات الملف الشخصي.';

  @override
  String get profileLoadError => 'تعذر تحميل بيانات الملف الشخصي.';

  @override
  String get passwordChangeUnavailable =>
      'تغيير كلمة المرور يحتاج ربط خدمة الحساب.';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get notificationsEnabled => 'تحديثات الطلب والإشعارات مفعلة';

  @override
  String get notificationsDisabled => 'الإشعارات متوقفة';

  @override
  String get appPreferences => 'تفضيلات التطبيق';

  @override
  String get appearance => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get languageSubtitle => 'العربية • اضغط لتغيير اللغة';

  @override
  String get privacyAndServicePolicy => 'الخصوصية وسياسة الخدمة';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get helpAndSupportSubtitle => 'تواصل مع فريق الدعم';

  @override
  String get supportSubtitle => 'نسعد بخدمتك';

  @override
  String get supportMessage => 'لو واجهتك أي مشكلة متترددش واتصل على';

  @override
  String get callUs => 'اتصل بنا';

  @override
  String get supportCallUnavailable => 'تعذر فتح تطبيق الاتصال على هذا الجهاز.';

  @override
  String get backButtonTooltip => 'رجوع';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutPrompt => 'متأكد إنك عايز تسجل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'تمام';

  @override
  String get logoutError => 'تعذر تسجيل الخروج.';

  @override
  String get appearanceSubtitle => 'اختار الشكل اللي يريحك.';

  @override
  String get saveAppearance => 'حفظ المظهر';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeSystem => 'استخدام إعداد الجهاز';

  @override
  String get themeSystemDescription => 'تتغير تلقائياً مع مظهر موبايلك.';

  @override
  String get selected => 'محدد';

  @override
  String get notSelected => 'غير محدد';

  @override
  String get appearancePrivacyNote =>
      'اختيار المظهر لا يغيّر بيانات حسابك أو الطلبات، ونفس خدماتك تفضل في كل الأوضاع.';

  @override
  String get languageTitle => 'لغة التطبيق';

  @override
  String get languageSlogan => 'تجربة مفهومة من أول كلمة.';

  @override
  String get languageDescription =>
      'اختار اللغة اللي تريحك، وتقدر تغيرها في أي وقت.';

  @override
  String get arabicLanguage => 'العربية';

  @override
  String get arabicLanguageDirection => 'من اليمين لليسار';

  @override
  String get englishLanguage => 'الإنجليزية';

  @override
  String get englishLanguageDirection => 'من اليسار لليمين';

  @override
  String get textPreview => 'معاينة النص';

  @override
  String get sampleGreeting => 'أهلاً بيك! محتاج إيه النهارده؟';

  @override
  String get sampleGreetingDescription => 'اطلب خدمة وتابع طلباتك بسهولة.';

  @override
  String get languagePrivacyNote =>
      'تغيير اللغة يغيّر واجهة التطبيق فقط، ومش هيأثر على بيانات حسابك أو طلباتك.';

  @override
  String get saveLanguage => 'حفظ اللغة';

  @override
  String get languageFooter => 'يتم تطبيق اللغة المختارة على واجهة التطبيق.';

  @override
  String get home => 'الرئيسية';

  @override
  String get services => 'خدماتي';

  @override
  String get categories => 'الأقسام';

  @override
  String get orders => 'الطلبات';

  @override
  String get myRequests => 'طلباتي';

  @override
  String get account => 'حسابي';

  @override
  String get providerServicesNavigation => 'خدماتي';

  @override
  String get providerOrdersNavigation => 'الطلبات';

  @override
  String get privacyTitle => 'خصوصيتك وحقوقك';

  @override
  String get privacySubtitle => 'الخصوصية وسياسة الخدمة • ٧ نوفمبر ٢٠٢٦';

  @override
  String get privacyNotice =>
      'نوضح لك أهم النقاط؛ هدفنا أن تكون تجربتك واضحة وآمنة للطرفين.';

  @override
  String get privacyDataHeading => 'بياناتك وعنوان الزيارة';

  @override
  String get privacyDataBody =>
      'نستخدم اسمك وخدماتك وعنوانك لتنسيق الطلب. قبل قبول الطلب، نتحقق من المنطقة والموعد فقط بالقدر اللازم. ويظهر رقم التواصل عند الحاجة لتنسيق الزيارة.';

  @override
  String get privacyPhotosHeading => 'صور العمل';

  @override
  String get privacyPhotosBody =>
      'رفع الصور اختياري، ويمكن استخدامها لتوضيح المشكلة أو عرض نماذج من الأعمال. ارفع الصور المرتبطة بالطلب فقط، وتجنب إظهار مستندات خاصة أو معلومات شخصية غير مرتبطة بالخدمة. لا تُستخدم الصور للإعلانات وفق هذه السياسة التوضيحية.';

  @override
  String get privacyBookingHeading => 'الحجز ورسوم المعاينة';

  @override
  String get privacyBookingBody =>
      'إرسال الطلب لا يعني تأكيد الحجز؛ انتظر قبول مقدم الخدمة. يجب توضيح رسوم المعاينة قبل إرسال الطلب. ولا تشمل المعاينة أعمال الإصلاح أو قطع الغيار إلا إذا تم الاتفاق على سعرها بوضوح مسبقاً.';

  @override
  String get privacyResponsibilitiesHeading => 'مسؤولية العميل والمتخصص';

  @override
  String get privacyResponsibilitiesBody =>
      'يوضح العميل المشكلة بدقة ويوفر وصولاً آمناً للمكان أو الجهاز. ويلتزم مقدم الخدمة بتأكيد السعر والموعد المتفق عليهما قبل بدء العمل. عند حدوث خلاف أو مشكلة في الخدمة، تواصل مع الدعم للمساعدة.';

  @override
  String get privacyCancellationHeading => 'التعديل والإلغاء';

  @override
  String get privacyCancellationBody =>
      'يمكنك طلب الإلغاء قبل موعد الزيارة. وفي المواعيد القريبة أو عند تأخر مقدم الخدمة، تواصل مع الدعم لترتيب بديل. لا تُفرض أي رسوم إضافية دون توضيحها والحصول على موافقتك مسبقاً.';

  @override
  String get privacyRetentionHeading => 'حفظ البيانات وحذفها والمساعدة';

  @override
  String get privacyRetentionBody =>
      'قد نحتفظ ببعض سجلات الطلبات للمساعدة في حل النزاعات أو للوفاء بالمتطلبات القانونية. يمكنك التواصل مع الدعم لمعرفة البيانات المحفوظة أو طلب حذفها متى كان ذلك مسموحاً. للاستفسار افتح «المساعدة والدعم» من حسابك.';

  @override
  String get privacyBack => 'فهمت، رجوع للإعدادات';

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
