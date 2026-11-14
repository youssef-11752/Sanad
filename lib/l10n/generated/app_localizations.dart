import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sanad'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Sanad home'**
  String get homeTitle;

  /// No description provided for @counterMessage.
  ///
  /// In en, this message translates to:
  /// **'You have pushed the button this many times:'**
  String get counterMessage;

  /// No description provided for @increment.
  ///
  /// In en, this message translates to:
  /// **'Increment'**
  String get increment;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @requestsTitle.
  ///
  /// In en, this message translates to:
  /// **'My requests'**
  String get requestsTitle;

  /// No description provided for @requestsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All your requests and appointments in one place'**
  String get requestsSubtitle;

  /// No description provided for @currentRequestsTab.
  ///
  /// In en, this message translates to:
  /// **'Current ({count})'**
  String currentRequestsTab(int count);

  /// No description provided for @pastRequestsTab.
  ///
  /// In en, this message translates to:
  /// **'Previous ({count})'**
  String pastRequestsTab(int count);

  /// No description provided for @noCurrentOrders.
  ///
  /// In en, this message translates to:
  /// **'No current orders.'**
  String get noCurrentOrders;

  /// No description provided for @noPreviousOrders.
  ///
  /// In en, this message translates to:
  /// **'No previous orders.'**
  String get noPreviousOrders;

  /// No description provided for @ordersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your orders.'**
  String get ordersLoadError;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @currentOrdersSection.
  ///
  /// In en, this message translates to:
  /// **'Current requests'**
  String get currentOrdersSection;

  /// No description provided for @pastVisitsSection.
  ///
  /// In en, this message translates to:
  /// **'Your previous visits'**
  String get pastVisitsSection;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @fulfilledStatus.
  ///
  /// In en, this message translates to:
  /// **'Fulfilled'**
  String get fulfilledStatus;

  /// No description provided for @newRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Request a new service'**
  String get newRequestButton;

  /// No description provided for @newRequestComingSoon.
  ///
  /// In en, this message translates to:
  /// **'New request creation is coming soon'**
  String get newRequestComingSoon;

  /// No description provided for @homeNavigation.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNavigation;

  /// No description provided for @categoriesNavigation.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesNavigation;

  /// No description provided for @myRequestsNavigation.
  ///
  /// In en, this message translates to:
  /// **'My requests'**
  String get myRequestsNavigation;

  /// No description provided for @accountNavigation.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountNavigation;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sanad'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Every craft has its Sanad.'**
  String get splashTagline;

  /// No description provided for @splashFooter.
  ///
  /// In en, this message translates to:
  /// **'Sanad for every home'**
  String get splashFooter;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to Sanad.'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to your account, and leave the rest to us 😏 .'**
  String get loginSubtitle;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLink;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @dataSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'Your data is safe. Your number and address are only shown to the professional after the visit is confirmed.'**
  String get dataSecurityNote;

  /// No description provided for @firstTimeHere.
  ///
  /// In en, this message translates to:
  /// **'First time here?'**
  String get firstTimeHere;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get createNewAccount;

  /// No description provided for @termsAgreementNote.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the Terms of Service and Privacy Policy.'**
  String get termsAgreementNote;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Sanad circle'**
  String get registerSubtitle;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters, including a letter and a number.'**
  String get passwordHint;

  /// No description provided for @agreeToPrivacyAndTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Privacy Policy and Terms of Service'**
  String get agreeToPrivacyAndTerms;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountButton;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasswordTitle;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email '**
  String get enterYourEmail;

  /// No description provided for @sendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendOtpButton;

  /// No description provided for @verifyOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Verify Your OTP'**
  String get verifyOtpButton;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your code'**
  String get otpTitle;

  /// No description provided for @otpMessage.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit verification code to You Make sure you enter the correct code.'**
  String get otpMessage;

  /// No description provided for @otpResendButton.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResendButton;

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordTitle;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get enterNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @passwordResetSuccessPrefix.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully. Please '**
  String get passwordResetSuccessPrefix;

  /// No description provided for @passwordResetSuccessAction.
  ///
  /// In en, this message translates to:
  /// **'log in'**
  String get passwordResetSuccessAction;

  /// No description provided for @goToLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Go to login'**
  String get goToLoginButton;

  /// No description provided for @hintFullName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Mariam Hassan'**
  String get hintFullName;

  /// No description provided for @hintPhone.
  ///
  /// In en, this message translates to:
  /// **'01135045965'**
  String get hintPhone;

  /// No description provided for @hintNationalId.
  ///
  /// In en, this message translates to:
  /// **'14 digits'**
  String get hintNationalId;

  /// No description provided for @hintEmail.
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get hintEmail;

  /// No description provided for @hintCity.
  ///
  /// In en, this message translates to:
  /// **'Select your city'**
  String get hintCity;

  /// No description provided for @hintArea.
  ///
  /// In en, this message translates to:
  /// **'Select your area'**
  String get hintArea;

  /// No description provided for @hintPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get hintPassword;

  /// No description provided for @hintConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get hintConfirmPassword;

  /// No description provided for @hintOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get hintOtp;

  /// No description provided for @errorFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorFieldRequired;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get errorInvalidPhone;

  /// No description provided for @errorInvalidNationalId.
  ///
  /// In en, this message translates to:
  /// **'Invalid national ID'**
  String get errorInvalidNationalId;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get errorInvalidEmail;

  /// No description provided for @errorPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get errorPasswordTooShort;

  /// No description provided for @errorPasswordWeak.
  ///
  /// In en, this message translates to:
  /// **'Password must include a letter and a number'**
  String get errorPasswordWeak;

  /// No description provided for @errorPasswordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordsNotMatch;

  /// No description provided for @errorInvalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get errorInvalidOtp;

  /// No description provided for @errorMustAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the Privacy Policy and Terms of Service'**
  String get errorMustAgreeTerms;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
