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
  /// **'Current (1)'**
  String get currentRequestsTab;

  /// No description provided for @pastRequestsTab.
  ///
  /// In en, this message translates to:
  /// **'Previous (3)'**
  String get pastRequestsTab;

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

  /// No description provided for @scheduledVisitStatus.
  ///
  /// In en, this message translates to:
  /// **'Visit scheduled'**
  String get scheduledVisitStatus;

  /// No description provided for @currentServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Automatic washing machine repair'**
  String get currentServiceTitle;

  /// No description provided for @currentProviderInfo.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Sayed • Nasr City'**
  String get currentProviderInfo;

  /// No description provided for @currentVisitDate.
  ///
  /// In en, this message translates to:
  /// **'Sunday, November 7 • 1–2 PM'**
  String get currentVisitDate;

  /// No description provided for @trackRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Track {requestId}'**
  String trackRequestButton(String requestId);

  /// No description provided for @trackRequestComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Details for request {requestId} are coming soon'**
  String trackRequestComingSoon(String requestId);

  /// No description provided for @completedStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatus;

  /// No description provided for @completedRatedStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed and rated'**
  String get completedRatedStatus;

  /// No description provided for @cancelledStatus.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStatus;

  /// No description provided for @pastRepairTitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen sink leak repair'**
  String get pastRepairTitle;

  /// No description provided for @pastRepairProvider.
  ///
  /// In en, this message translates to:
  /// **'Hossam Adel • Maadi'**
  String get pastRepairProvider;

  /// No description provided for @pastRepairDate.
  ///
  /// In en, this message translates to:
  /// **'October 28, 2026 • 4:30 PM'**
  String get pastRepairDate;

  /// No description provided for @pastFridgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator maintenance'**
  String get pastFridgeTitle;

  /// No description provided for @pastFridgeProvider.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Sayed • Nasr City'**
  String get pastFridgeProvider;

  /// No description provided for @pastFridgeDate.
  ///
  /// In en, this message translates to:
  /// **'September 15, 2026 • 3 PM'**
  String get pastFridgeDate;

  /// No description provided for @pastLightTitle.
  ///
  /// In en, this message translates to:
  /// **'Light fixture installation'**
  String get pastLightTitle;

  /// No description provided for @pastLightProvider.
  ///
  /// In en, this message translates to:
  /// **'Ibrahim • Nasr City'**
  String get pastLightProvider;

  /// No description provided for @pastLightDate.
  ///
  /// In en, this message translates to:
  /// **'September 1, 2026'**
  String get pastLightDate;

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
