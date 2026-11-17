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
  String get backNavigation => 'Back';

  @override
  String get deleteRequestTooltip => 'Delete request';

  @override
  String get deleteRequestTitle => 'Delete request';

  @override
  String get deleteRequestConfirmation =>
      'Are you sure you want to delete this request? This cannot be undone.';

  @override
  String get deleteButton => 'Delete';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get requestDeletedMessage => 'The request was deleted.';

  @override
  String get requestDeleteError =>
      'Couldn\'t delete the request. It may have been assigned to a provider.';

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
  String get categoriesTitle => 'All categories';

  @override
  String get categoriesSubtitle => 'Choose the service you need';

  @override
  String get homeServicesLabel => 'Home services';

  @override
  String get categoriesSearchHint => 'Search for a service or issue';

  @override
  String get categoriesNoResults => 'No categories match your search';

  @override
  String get homeSearchNoResults => 'No services match your search';

  @override
  String get allRequestsLink => 'All requests';

  @override
  String get homeAddressTitle => 'Service address';

  @override
  String get homeBannerEyebrow => 'Skilled help, closer with Sanad';

  @override
  String get homeBannerTitle => 'A skilled professional for every repair';

  @override
  String get homeBannerDescription =>
      'Trusted professionals for all your home services';

  @override
  String get homeRequestServiceButton => 'Request a service';

  @override
  String get homeServicePrompt => 'What service do you need today?';

  @override
  String get homeRecommendedProviders => 'Recommended professionals';

  @override
  String get viewAll => 'View all';

  @override
  String get homeProviderSpecialty => 'Home appliance repair specialist';

  @override
  String get homeResponseTime => 'Available in 30 minutes';

  @override
  String providerRating(String rating, int count) {
    return '$rating ($count reviews)';
  }

  @override
  String providerExperience(int years) {
    return '$years years of experience';
  }

  @override
  String get providerAvailableToday => 'Available today';

  @override
  String get providerAvailableTomorrow => 'Available tomorrow';

  @override
  String providerVisitPrice(int price) {
    return 'EGP $price per visit';
  }

  @override
  String get newRequestTitle => 'New service request';

  @override
  String get requestCategoryLabel => 'Service category';

  @override
  String get requestCityLabel => 'City';

  @override
  String get requestTitleLabel => 'Request title';

  @override
  String get requestDetailsLabel => 'Problem details';

  @override
  String get requestAddressLabel => 'Detailed address';

  @override
  String get chooseRequestCategory => 'Choose a service category';

  @override
  String get chooseRequestCity => 'Choose a city';

  @override
  String get requestSubmitButton => 'Submit request';

  @override
  String get requestOptionsError => 'Couldn\'t load services and cities.';

  @override
  String get requestCreateError => 'Couldn\'t create the request.';

  @override
  String get requestCreatedMessage =>
      'Your request was submitted successfully.';

  @override
  String get requestNoCategories =>
      'No categories found. Check the data and Supabase read access.';

  @override
  String get requestNoCities =>
      'No cities found. Check the data and Supabase read access.';

  @override
  String get navigationComingSoon => 'This section is coming soon';

  @override
  String get profileSettingsTitle => 'My account and settings';

  @override
  String get accountProvider => 'Service provider account';

  @override
  String get accountCustomer => 'Customer account';

  @override
  String get yourAccount => 'Your account';

  @override
  String get personalProfile => 'Personal profile';

  @override
  String get personalProfileSubtitle => 'Your name, phone number and details';

  @override
  String get profileWelcome => 'Welcome to Sanad';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get phoneNumberLabel => 'Mobile number';

  @override
  String get cityLabel => 'City';

  @override
  String get districtLabel => 'District';

  @override
  String get passwordLabel => 'Password';

  @override
  String get profilePasswordHint =>
      'At least 8 characters, including a letter and a number.';

  @override
  String get profileOkay => 'Okay, I understand';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get saveProfile => 'Save changes';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidPhoneNumber => 'Enter a valid phone number';

  @override
  String get profileSaved => 'Profile details updated';

  @override
  String get profileSaveError => 'Couldn\'t save profile details.';

  @override
  String get profileLoadError => 'Couldn\'t load your profile.';

  @override
  String get passwordChangeUnavailable =>
      'Password changes need an account service connection.';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsEnabled => 'Order updates and notifications are on';

  @override
  String get notificationsDisabled => 'Notifications are turned off';

  @override
  String get appPreferences => 'App preferences';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'English • Tap to change language';

  @override
  String get privacyAndServicePolicy => 'Privacy and service policy';

  @override
  String get helpAndSupport => 'Help and support';

  @override
  String get helpAndSupportSubtitle => 'Contact the support team';

  @override
  String get supportSubtitle => 'We are happy to help';

  @override
  String get supportMessage =>
      'If you have any issue, don\'t hesitate to call us at';

  @override
  String get callUs => 'Call us';

  @override
  String get supportCallUnavailable =>
      'The phone app could not be opened on this device.';

  @override
  String get backButtonTooltip => 'Back';

  @override
  String get logout => 'Log out';

  @override
  String get logoutPrompt => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get logoutError => 'Couldn\'t sign out.';

  @override
  String get appearanceSubtitle => 'Choose the look you prefer.';

  @override
  String get saveAppearance => 'Save appearance';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'Use device settings';

  @override
  String get themeSystemDescription =>
      'Automatically follows your device theme.';

  @override
  String get selected => 'Selected';

  @override
  String get notSelected => 'Not selected';

  @override
  String get appearancePrivacyNote =>
      'Changing the appearance does not affect your account or orders. Your services stay the same.';

  @override
  String get languageTitle => 'App language';

  @override
  String get languageSlogan =>
      'An experience you understand from the first word.';

  @override
  String get languageDescription =>
      'Choose the language you prefer. You can change it at any time.';

  @override
  String get arabicLanguage => 'Arabic';

  @override
  String get arabicLanguageDirection => 'Right to left';

  @override
  String get englishLanguage => 'English';

  @override
  String get englishLanguageDirection => 'Left to right';

  @override
  String get textPreview => 'Text preview';

  @override
  String get sampleGreeting => 'Hello! What do you need today?';

  @override
  String get sampleGreetingDescription =>
      'Request a service and follow your orders easily.';

  @override
  String get languagePrivacyNote =>
      'Changing the language only updates the app interface. Your account details and requests stay the same.';

  @override
  String get saveLanguage => 'Save language';

  @override
  String get languageFooter =>
      'Your language preference is saved for this app session.';

  @override
  String get home => 'Home';

  @override
  String get services => 'Services';

  @override
  String get categories => 'Categories';

  @override
  String get orders => 'Orders';

  @override
  String get myRequests => 'My requests';

  @override
  String get account => 'Account';

  @override
  String get providerServicesNavigation => 'My services';

  @override
  String get providerOrdersNavigation => 'Orders';

  @override
  String get privacyTitle => 'Your privacy and rights';

  @override
  String get privacySubtitle =>
      'Privacy and service policy • Updated 7 November 2026';

  @override
  String get privacyNotice =>
      'We want your experience to be clear and safe for everyone. This page explains the main points for both sides.';

  @override
  String get privacyDataHeading => 'Your data and visit address';

  @override
  String get privacyDataBody =>
      'We use your name, service details and visit address to coordinate a request. Before a request is accepted, only the information needed to check the service area and appointment is used. Your contact details are shared only as needed to arrange the visit.';

  @override
  String get privacyPhotosHeading => 'Work photos';

  @override
  String get privacyPhotosBody =>
      'Uploading photos is optional. Photos can help explain the issue or show examples of completed work. Share only images relevant to the request, and avoid including private documents or unrelated personal information. Photos are not used for advertising in this sample policy.';

  @override
  String get privacyBookingHeading => 'Bookings and inspection fees';

  @override
  String get privacyBookingBody =>
      'Sending a request does not mean the booking is confirmed. Wait for the service provider to accept it. Any inspection fee should be shown before you submit the request. Repair work or spare parts are not included unless their price is clearly agreed in advance.';

  @override
  String get privacyResponsibilitiesHeading =>
      'Customer and service provider responsibilities';

  @override
  String get privacyResponsibilitiesBody =>
      'The customer should describe the issue accurately and provide safe access to the place or device. The service provider should confirm the agreed price and appointment before starting work. If a disagreement or service problem occurs, contact support so the team can help.';

  @override
  String get privacyCancellationHeading => 'Changes and cancellation';

  @override
  String get privacyCancellationBody =>
      'You can request a cancellation before the service visit. For a nearby appointment or a provider delay, contact support to arrange an alternative. No additional fee should be charged without being explained and approved in advance.';

  @override
  String get privacyRetentionHeading => 'Data retention, deletion and support';

  @override
  String get privacyRetentionBody =>
      'Some request records may need to be kept to resolve disputes or meet legal requirements. You can contact support to ask what data is held or request deletion where permitted. Open Help and support from your account to ask a question.';

  @override
  String get privacyBack => 'I understand — back to settings';

  @override
  String categoryComingSoon(String category) {
    return '$category services are coming soon';
  }

  @override
  String get applianceCategory => 'Home appliance maintenance';

  @override
  String get applianceCategoryDescription =>
      'Repair and maintenance for home appliances';

  @override
  String get paintingCategory => 'Painting';

  @override
  String get paintingCategoryDescription =>
      'Painting, decor, and wall renovations';

  @override
  String get carpentryCategory => 'Carpentry';

  @override
  String get carpentryCategoryDescription =>
      'Home furniture repair and carpentry';

  @override
  String get electricalCategory => 'Electrical';

  @override
  String get electricalCategoryDescription =>
      'Home wiring, lighting, switches, and panels';

  @override
  String get airConditioningCategory => 'Air conditioning';

  @override
  String get airConditioningCategoryDescription =>
      'Air conditioner repair and installation';

  @override
  String get plumbingCategory => 'Plumbing';

  @override
  String get plumbingCategoryDescription => 'Leak repair and pipe installation';

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
