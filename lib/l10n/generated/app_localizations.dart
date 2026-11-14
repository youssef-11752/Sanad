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

  /// No description provided for @navigationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This section is coming soon'**
  String get navigationComingSoon;

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
