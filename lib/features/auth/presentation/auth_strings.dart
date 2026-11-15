import 'package:flutter/widgets.dart';

class AuthStrings {
  const AuthStrings(this.isArabic);
  final bool isArabic;

  factory AuthStrings.of(BuildContext context) =>
      AuthStrings(Localizations.localeOf(context).languageCode == 'ar');

  String get appName => isArabic ? 'سند' : 'Sanad';
  String get customer => isArabic ? 'العميل' : 'Customer';
  String get provider => isArabic ? 'مقدم الخدمة' : 'Service provider';
  String get loginTitle => isArabic ? 'نورت سند من جديد' : 'Welcome back to Sanad';
  String get loginSubtitle => isArabic
      ? 'ادخل لحسابك، وخلّي الباقي علينا.'
      : 'Log in to your account and leave the rest to us.';
  String get email => isArabic ? 'البريد الإلكتروني' : 'Email';
  String get password => isArabic ? 'كلمة المرور' : 'Password';
  String get forgotPassword => isArabic ? 'نسيت كلمة المرور؟' : 'Forgot password?';
  String get login => isArabic ? 'تسجيل الدخول' : 'Log in';
  String get noAccount => isArabic ? 'أول مرة معانا؟' : 'First time here?';
  String get createAccount => isArabic ? 'إنشاء حساب جديد' : 'Create a new account';
  String get securityNote => isArabic
      ? 'بياناتك بأمان. رقمك وعنوانك لا يظهران إلا للمتخصص بعد تأكيد الزيارة.'
      : 'Your data is safe. Your number and address are only shown to the professional after the visit is confirmed.';
  String get termsNote => isArabic
      ? 'بالمتابعة، أنت توافق على سياسة الخدمة والخصوصية.'
      : 'By continuing, you agree to the Terms of Service and Privacy Policy.';
  String get signupTitle => isArabic ? 'حساب جديد' : 'New account';
  String get signupSubtitle => isArabic ? 'أهلاً بيك في دايرة سند' : 'Welcome to the Sanad circle';
  String get fullName => isArabic ? 'الاسم بالكامل' : 'Full name';
  String get city => isArabic ? 'المدينة' : 'City';
  String get area => isArabic ? 'المنطقة' : 'Area';
  String get hintName => isArabic ? 'مثال: مريم حسن' : 'e.g. Mariam Hassan';
  String get hintEmail => 'example@gmail.com';
  String get hintCity => isArabic ? 'القاهرة' : 'Cairo';
  String get hintArea => isArabic ? 'مدينة نصر' : 'Nasr City';
  String get hintPassword => isArabic ? '٨ أحرف على الأقل' : 'At least 8 characters';
  String get acceptTerms => isArabic
      ? 'أوافق على سياسة الخصوصية وشروط الخدمة'
      : 'I agree to the Privacy Policy and Terms of Service';
  String get create => isArabic ? 'إنشاء حساب' : 'Create account';
  String get haveAccount => isArabic ? 'عندك حساب؟' : 'Already have an account?';
  String get sendCode => isArabic ? 'إرسال رمز التحقق' : 'Send verification code';
  String get forgotTitle => isArabic ? 'نسيت كلمة المرور' : 'Forgot password';
  String get enterEmail => isArabic ? 'ادخل البريد الإلكتروني' : 'Enter your email';
  String get otpTitle => isArabic ? 'إدخال رمز التحقق' : 'Enter verification code';
  String get otpMessage => isArabic
      ? 'أدخل الرمز المكوّن من 6 أرقام الذي أرسلناه إلى بريدك الإلكتروني.'
      : 'Enter the 6-digit code sent to your email address.';
  String get verify => isArabic ? 'تحقق من الرمز' : 'Verify code';
  String get newPasswordTitle => isArabic ? 'كلمة مرور جديدة' : 'New password';
  String get enterNewPassword => isArabic ? 'أدخل كلمة المرور الجديدة' : 'Enter your new password';
  String get confirmPassword => isArabic ? 'تأكيد كلمة المرور' : 'Confirm password';
  String get savePassword => isArabic ? 'حفظ كلمة المرور' : 'Save password';
  String get passwordResetDone => isArabic
      ? 'تم تحديث كلمة المرور بنجاح.'
      : 'Your password has been updated successfully.';
  String get goToLogin => isArabic ? 'العودة لتسجيل الدخول' : 'Back to login';
  String get requiredField => isArabic ? 'هذا الحقل مطلوب' : 'This field is required';
  String get invalidEmail => isArabic ? 'البريد الإلكتروني غير صحيح' : 'Enter a valid email';
  String get shortPassword => isArabic
      ? 'كلمة المرور يجب ألا تقل عن ٨ أحرف'
      : 'Password must be at least 8 characters';
  String get passwordsMismatch => isArabic
      ? 'كلمتا المرور غير متطابقتين'
      : 'Passwords do not match';
  String get agreeTermsError => isArabic
      ? 'يجب الموافقة على سياسة الخصوصية وشروط الخدمة'
      : 'You must accept the Privacy Policy and Terms of Service';
  String get accountRoleMissing => isArabic
      ? 'نوع الحساب غير محدد لهذا المستخدم. تواصل مع الدعم لتحديث بيانات الحساب.'
      : 'This account has no assigned role. Contact support to update the account.';
  String get wrongAccountRole => isArabic
      ? 'هذا الحساب مسجل بنوع مستخدم مختلف.'
      : 'This account is registered for a different user role.';
  String get genericAuthError => isArabic
      ? 'تعذر إكمال العملية. حاول مرة أخرى.'
      : 'The operation could not be completed. Please try again.';
  String get startupError => isArabic
      ? 'تعذر تشغيل التطبيق. تأكد من إعدادات الاتصال ثم أعد المحاولة.'
      : 'The app could not start. Check the connection settings and try again.';
  String get retry => isArabic ? 'إعادة المحاولة' : 'Retry';
  String get splashTagline => isArabic ? 'كل صنعة، لها سند.' : 'Every craft has its Sanad.';
  String get splashFooter => isArabic ? 'سند لكل بيت' : 'Sanad for every home';
  String get chooseRole => isArabic ? 'إزاي نقدر نكون سندك؟' : 'How can Sanad help you?';
  String get chooseRoleSubtitle => isArabic
      ? 'اختار طريقة استخدامك للتطبيق.'
      : 'Choose how you want to use the app.';
  String get continueAsCustomer => isArabic ? 'متابعة كعميل' : 'Continue as customer';
  String get continueAsProvider => isArabic ? 'متابعة كمقدم خدمة' : 'Continue as provider';
  String get providerDashboard => isArabic ? 'لوحة مقدم الخدمة' : 'Provider dashboard';
  String get providerDashboardPending => isArabic
      ? 'تم تسجيل الدخول كمقدم خدمة. شاشات إدارة الطلبات والتخصص قيد الاستكمال.'
      : 'You are signed in as a provider. Request management and specialty screens are still being implemented.';
  String get demoPlaceholder => isArabic ? 'واجهة أولية - بيانات غير متصلة' : 'UI foundation - not connected to live data';
}
