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

  @override
  String get requestsTitle => 'My requests';

  @override
  String get requestsSubtitle =>
      'All your requests and appointments in one place';

  @override
  String currentRequestsTab(int count) {
    return 'Current ($count)';
  }

  @override
  String pastRequestsTab(int count) {
    return 'Previous ($count)';
  }

  @override
  String get noCurrentOrders => 'No current orders.';

  @override
  String get noPreviousOrders => 'No previous orders.';

  @override
  String get ordersLoadError => 'Couldn\'t load your orders.';

  @override
  String get retryButton => 'Retry';

  @override
  String get currentOrdersSection => 'Current requests';

  @override
  String get pastVisitsSection => 'Your previous visits';

  @override
  String get pendingStatus => 'Pending';

  @override
  String get fulfilledStatus => 'Fulfilled';

  @override
  String get newRequestButton => 'Request a new service';

  @override
  String get newRequestComingSoon => 'New request creation is coming soon';

  @override
  String get homeNavigation => 'Home';

  @override
  String get categoriesNavigation => 'Categories';

  @override
  String get myRequestsNavigation => 'My requests';

  @override
  String get accountNavigation => 'Account';

  @override
  String get appName => 'Sanad';

  @override
  String get splashTagline => 'Every craft has its Sanad.';

  @override
  String get splashFooter => 'Sanad for every home';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get nationalId => 'National ID';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get fullName => 'Full name';

  @override
  String get city => 'City';

  @override
  String get area => 'Area';

  @override
  String get loginTitle => 'Welcome back to Sanad.';

  @override
  String get loginSubtitle =>
      'Log in to your account, and leave the rest to us 😏 .';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String get loginButton => 'Log in';

  @override
  String get dataSecurityNote =>
      'Your data is safe. Your number and address are only shown to the professional after the visit is confirmed.';

  @override
  String get firstTimeHere => 'First time here?';

  @override
  String get createNewAccount => 'Create a new account';

  @override
  String get termsAgreementNote =>
      'By continuing, you agree to the Terms of Service and Privacy Policy.';

  @override
  String get registerTitle => 'New account';

  @override
  String get registerSubtitle => 'Welcome to the Sanad circle';

  @override
  String get passwordHint =>
      'At least 8 characters, including a letter and a number.';

  @override
  String get agreeToPrivacyAndTerms =>
      'I agree to the Privacy Policy and Terms of Service';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get enterYourEmail => 'Enter your Email ';

  @override
  String get sendOtpButton => 'Send code';

  @override
  String get verifyOtpButton => 'Verify Your OTP';

  @override
  String get otpTitle => 'Enter your code';

  @override
  String get otpMessage =>
      'We sent a 6-digit verification code to You Make sure you enter the correct code.';

  @override
  String get otpResendButton => 'Resend code';

  @override
  String get newPasswordTitle => 'New password';

  @override
  String get enterNewPassword => 'Please enter a new password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get doneButton => 'Done';

  @override
  String get passwordResetSuccessPrefix =>
      'Your password has been reset successfully. Please ';

  @override
  String get passwordResetSuccessAction => 'log in';

  @override
  String get goToLoginButton => 'Go to login';

  @override
  String get hintFullName => 'e.g. Mariam Hassan';

  @override
  String get hintPhone => '01135045965';

  @override
  String get hintNationalId => '14 digits';

  @override
  String get hintEmail => 'example@gmail.com';

  @override
  String get hintCity => 'Select your city';

  @override
  String get hintArea => 'Select your area';

  @override
  String get hintPassword => 'Enter your password';

  @override
  String get hintConfirmPassword => 'Re-enter your password';

  @override
  String get hintOtp => 'Enter the code';

  @override
  String get errorFieldRequired => 'This field is required';

  @override
  String get errorInvalidPhone => 'Invalid phone number';

  @override
  String get errorInvalidNationalId => 'Invalid national ID';

  @override
  String get errorInvalidEmail => 'Invalid email';

  @override
  String get errorPasswordTooShort => 'Password must be at least 8 characters';

  @override
  String get errorPasswordWeak => 'Password must include a letter and a number';

  @override
  String get errorPasswordsNotMatch => 'Passwords do not match';

  @override
  String get errorInvalidOtp => 'Invalid code';

  @override
  String get errorMustAgreeTerms =>
      'You must agree to the Privacy Policy and Terms of Service';
}
