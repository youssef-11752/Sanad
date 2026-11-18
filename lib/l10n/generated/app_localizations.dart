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

  /// No description provided for @backNavigation.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backNavigation;

  /// No description provided for @deleteRequestTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete request'**
  String get deleteRequestTooltip;

  /// No description provided for @deleteRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete request'**
  String get deleteRequestTitle;

  /// No description provided for @deleteRequestConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this request? This cannot be undone.'**
  String get deleteRequestConfirmation;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @requestDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'The request was deleted.'**
  String get requestDeletedMessage;

  /// No description provided for @requestDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete the request. It may have been assigned to a provider.'**
  String get requestDeleteError;

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

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get categoriesTitle;

  /// No description provided for @categoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the service you need'**
  String get categoriesSubtitle;

  /// No description provided for @homeServicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Home services'**
  String get homeServicesLabel;

  /// No description provided for @categoriesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a service or issue'**
  String get categoriesSearchHint;

  /// No description provided for @categoriesNoResults.
  ///
  /// In en, this message translates to:
  /// **'No categories match your search'**
  String get categoriesNoResults;

  /// No description provided for @homeSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No services match your search'**
  String get homeSearchNoResults;

  /// No description provided for @allRequestsLink.
  ///
  /// In en, this message translates to:
  /// **'All requests'**
  String get allRequestsLink;

  /// No description provided for @homeAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Service address'**
  String get homeAddressTitle;

  /// No description provided for @homeBannerEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Skilled help, closer with Sanad'**
  String get homeBannerEyebrow;

  /// No description provided for @homeBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'A skilled professional for every repair'**
  String get homeBannerTitle;

  /// No description provided for @homeBannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Trusted professionals for all your home services'**
  String get homeBannerDescription;

  /// No description provided for @homeRequestServiceButton.
  ///
  /// In en, this message translates to:
  /// **'Request a service'**
  String get homeRequestServiceButton;

  /// No description provided for @homeServicePrompt.
  ///
  /// In en, this message translates to:
  /// **'What service do you need today?'**
  String get homeServicePrompt;

  /// No description provided for @homeRecommendedProviders.
  ///
  /// In en, this message translates to:
  /// **'Recommended professionals'**
  String get homeRecommendedProviders;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @homeProviderSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Home appliance repair specialist'**
  String get homeProviderSpecialty;

  /// No description provided for @homeResponseTime.
  ///
  /// In en, this message translates to:
  /// **'Available in 30 minutes'**
  String get homeResponseTime;

  /// No description provided for @providerRating.
  ///
  /// In en, this message translates to:
  /// **'{rating} ({count} reviews)'**
  String providerRating(String rating, int count);

  /// No description provided for @providerExperience.
  ///
  /// In en, this message translates to:
  /// **'{years} years of experience'**
  String providerExperience(int years);

  /// No description provided for @providerAvailableToday.
  ///
  /// In en, this message translates to:
  /// **'Available today'**
  String get providerAvailableToday;

  /// No description provided for @providerAvailableTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Available tomorrow'**
  String get providerAvailableTomorrow;

  /// No description provided for @providerVisitPrice.
  ///
  /// In en, this message translates to:
  /// **'EGP {price} per visit'**
  String providerVisitPrice(int price);

  /// No description provided for @newRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'New service request'**
  String get newRequestTitle;

  /// No description provided for @requestCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Service category'**
  String get requestCategoryLabel;

  /// No description provided for @requestCityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get requestCityLabel;

  /// No description provided for @requestTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Request title'**
  String get requestTitleLabel;

  /// No description provided for @requestDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Problem details'**
  String get requestDetailsLabel;

  /// No description provided for @requestAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Detailed address'**
  String get requestAddressLabel;

  /// No description provided for @chooseRequestCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a service category'**
  String get chooseRequestCategory;

  /// No description provided for @chooseRequestCity.
  ///
  /// In en, this message translates to:
  /// **'Choose a city'**
  String get chooseRequestCity;

  /// No description provided for @requestSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit request'**
  String get requestSubmitButton;

  /// No description provided for @requestOptionsError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load services and cities.'**
  String get requestOptionsError;

  /// No description provided for @requestCreateError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t create the request.'**
  String get requestCreateError;

  /// No description provided for @requestCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your request was submitted successfully.'**
  String get requestCreatedMessage;

  /// No description provided for @requestNoCategories.
  ///
  /// In en, this message translates to:
  /// **'No categories found. Check the data and Supabase read access.'**
  String get requestNoCategories;

  /// No description provided for @requestNoCities.
  ///
  /// In en, this message translates to:
  /// **'No cities found. Check the data and Supabase read access.'**
  String get requestNoCities;

  /// No description provided for @navigationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This section is coming soon'**
  String get navigationComingSoon;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My account and settings'**
  String get profileSettingsTitle;

  /// No description provided for @accountProvider.
  ///
  /// In en, this message translates to:
  /// **'Service provider account'**
  String get accountProvider;

  /// No description provided for @accountCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer account'**
  String get accountCustomer;

  /// No description provided for @yourAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account'**
  String get yourAccount;

  /// No description provided for @personalProfile.
  ///
  /// In en, this message translates to:
  /// **'Personal profile'**
  String get personalProfile;

  /// No description provided for @personalProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your name, phone number and details'**
  String get personalProfileSubtitle;

  /// No description provided for @profileWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sanad'**
  String get profileWelcome;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get phoneNumberLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @districtLabel.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get districtLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @profilePasswordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters, including a letter and a number.'**
  String get profilePasswordHint;

  /// No description provided for @profileOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay, I understand'**
  String get profileOkay;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveProfile;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile details updated'**
  String get profileSaved;

  /// No description provided for @profileSaveError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save profile details.'**
  String get profileSaveError;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your profile.'**
  String get profileLoadError;

  /// No description provided for @passwordChangeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Password changes need an account service connection.'**
  String get passwordChangeUnavailable;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Order updates and notifications are on'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off'**
  String get notificationsDisabled;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App preferences'**
  String get appPreferences;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'English • Tap to change language'**
  String get languageSubtitle;

  /// No description provided for @privacyAndServicePolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and service policy'**
  String get privacyAndServicePolicy;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get helpAndSupport;

  /// No description provided for @helpAndSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Contact the support team'**
  String get helpAndSupportSubtitle;

  /// No description provided for @supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We are happy to help'**
  String get supportSubtitle;

  /// No description provided for @supportMessage.
  ///
  /// In en, this message translates to:
  /// **'If you have any issue, don\'t hesitate to call us at'**
  String get supportMessage;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get callUs;

  /// No description provided for @supportCallUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The phone app could not be opened on this device.'**
  String get supportCallUnavailable;

  /// No description provided for @backButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButtonTooltip;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutPrompt.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutPrompt;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @logoutError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t sign out.'**
  String get logoutError;

  /// No description provided for @appearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the look you prefer.'**
  String get appearanceSubtitle;

  /// No description provided for @saveAppearance.
  ///
  /// In en, this message translates to:
  /// **'Save appearance'**
  String get saveAppearance;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Use device settings'**
  String get themeSystem;

  /// No description provided for @themeSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically follows your device theme.'**
  String get themeSystemDescription;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @appearancePrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Changing the appearance does not affect your account or orders. Your services stay the same.'**
  String get appearancePrivacyNote;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get languageTitle;

  /// No description provided for @languageSlogan.
  ///
  /// In en, this message translates to:
  /// **'An experience you understand from the first word.'**
  String get languageSlogan;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language you prefer. You can change it at any time.'**
  String get languageDescription;

  /// No description provided for @arabicLanguage.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLanguage;

  /// No description provided for @arabicLanguageDirection.
  ///
  /// In en, this message translates to:
  /// **'Right to left'**
  String get arabicLanguageDirection;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @englishLanguageDirection.
  ///
  /// In en, this message translates to:
  /// **'Left to right'**
  String get englishLanguageDirection;

  /// No description provided for @textPreview.
  ///
  /// In en, this message translates to:
  /// **'Text preview'**
  String get textPreview;

  /// No description provided for @sampleGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello! What do you need today?'**
  String get sampleGreeting;

  /// No description provided for @sampleGreetingDescription.
  ///
  /// In en, this message translates to:
  /// **'Request a service and follow your orders easily.'**
  String get sampleGreetingDescription;

  /// No description provided for @languagePrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Changing the language only updates the app interface. Your account details and requests stay the same.'**
  String get languagePrivacyNote;

  /// No description provided for @saveLanguage.
  ///
  /// In en, this message translates to:
  /// **'Save language'**
  String get saveLanguage;

  /// No description provided for @languageFooter.
  ///
  /// In en, this message translates to:
  /// **'Your language preference is saved for this app session.'**
  String get languageFooter;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My requests'**
  String get myRequests;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @providerServicesNavigation.
  ///
  /// In en, this message translates to:
  /// **'My services'**
  String get providerServicesNavigation;

  /// No description provided for @providerOrdersNavigation.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get providerOrdersNavigation;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your privacy and rights'**
  String get privacyTitle;

  /// No description provided for @privacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and service policy • Updated 7 November 2026'**
  String get privacySubtitle;

  /// No description provided for @privacyNotice.
  ///
  /// In en, this message translates to:
  /// **'We want your experience to be clear and safe for everyone. This page explains the main points for both sides.'**
  String get privacyNotice;

  /// No description provided for @privacyDataHeading.
  ///
  /// In en, this message translates to:
  /// **'Your data and visit address'**
  String get privacyDataHeading;

  /// No description provided for @privacyDataBody.
  ///
  /// In en, this message translates to:
  /// **'We use your name, service details and visit address to coordinate a request. Before a request is accepted, only the information needed to check the service area and appointment is used. Your contact details are shared only as needed to arrange the visit.'**
  String get privacyDataBody;

  /// No description provided for @privacyPhotosHeading.
  ///
  /// In en, this message translates to:
  /// **'Work photos'**
  String get privacyPhotosHeading;

  /// No description provided for @privacyPhotosBody.
  ///
  /// In en, this message translates to:
  /// **'Uploading photos is optional. Photos can help explain the issue or show examples of completed work. Share only images relevant to the request, and avoid including private documents or unrelated personal information. Photos are not used for advertising in this sample policy.'**
  String get privacyPhotosBody;

  /// No description provided for @privacyBookingHeading.
  ///
  /// In en, this message translates to:
  /// **'Bookings and inspection fees'**
  String get privacyBookingHeading;

  /// No description provided for @privacyBookingBody.
  ///
  /// In en, this message translates to:
  /// **'Sending a request does not mean the booking is confirmed. Wait for the service provider to accept it. Any inspection fee should be shown before you submit the request. Repair work or spare parts are not included unless their price is clearly agreed in advance.'**
  String get privacyBookingBody;

  /// No description provided for @privacyResponsibilitiesHeading.
  ///
  /// In en, this message translates to:
  /// **'Customer and service provider responsibilities'**
  String get privacyResponsibilitiesHeading;

  /// No description provided for @privacyResponsibilitiesBody.
  ///
  /// In en, this message translates to:
  /// **'The customer should describe the issue accurately and provide safe access to the place or device. The service provider should confirm the agreed price and appointment before starting work. If a disagreement or service problem occurs, contact support so the team can help.'**
  String get privacyResponsibilitiesBody;

  /// No description provided for @privacyCancellationHeading.
  ///
  /// In en, this message translates to:
  /// **'Changes and cancellation'**
  String get privacyCancellationHeading;

  /// No description provided for @privacyCancellationBody.
  ///
  /// In en, this message translates to:
  /// **'You can request a cancellation before the service visit. For a nearby appointment or a provider delay, contact support to arrange an alternative. No additional fee should be charged without being explained and approved in advance.'**
  String get privacyCancellationBody;

  /// No description provided for @privacyRetentionHeading.
  ///
  /// In en, this message translates to:
  /// **'Data retention, deletion and support'**
  String get privacyRetentionHeading;

  /// No description provided for @privacyRetentionBody.
  ///
  /// In en, this message translates to:
  /// **'Some request records may need to be kept to resolve disputes or meet legal requirements. You can contact support to ask what data is held or request deletion where permitted. Open Help and support from your account to ask a question.'**
  String get privacyRetentionBody;

  /// No description provided for @privacyBack.
  ///
  /// In en, this message translates to:
  /// **'I understand — back to settings'**
  String get privacyBack;

  /// No description provided for @categoryComingSoon.
  ///
  /// In en, this message translates to:
  /// **'{category} services are coming soon'**
  String categoryComingSoon(String category);

  /// No description provided for @applianceCategory.
  ///
  /// In en, this message translates to:
  /// **'Home appliance maintenance'**
  String get applianceCategory;

  /// No description provided for @applianceCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Repair and maintenance for home appliances'**
  String get applianceCategoryDescription;

  /// No description provided for @paintingCategory.
  ///
  /// In en, this message translates to:
  /// **'Painting'**
  String get paintingCategory;

  /// No description provided for @paintingCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Painting, decor, and wall renovations'**
  String get paintingCategoryDescription;

  /// No description provided for @carpentryCategory.
  ///
  /// In en, this message translates to:
  /// **'Carpentry'**
  String get carpentryCategory;

  /// No description provided for @carpentryCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Home furniture repair and carpentry'**
  String get carpentryCategoryDescription;

  /// No description provided for @electricalCategory.
  ///
  /// In en, this message translates to:
  /// **'Electrical'**
  String get electricalCategory;

  /// No description provided for @electricalCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Home wiring, lighting, switches, and panels'**
  String get electricalCategoryDescription;

  /// No description provided for @airConditioningCategory.
  ///
  /// In en, this message translates to:
  /// **'Air conditioning'**
  String get airConditioningCategory;

  /// No description provided for @airConditioningCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Air conditioner repair and installation'**
  String get airConditioningCategoryDescription;

  /// No description provided for @plumbingCategory.
  ///
  /// In en, this message translates to:
  /// **'Plumbing'**
  String get plumbingCategory;

  /// No description provided for @plumbingCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Leak repair and pipe installation'**
  String get plumbingCategoryDescription;

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
