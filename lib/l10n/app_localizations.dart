import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HomeBook'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @searchServicesHint.
  ///
  /// In en, this message translates to:
  /// **'Search services…'**
  String get searchServicesHint;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get categoryCleaning;

  /// No description provided for @categoryRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get categoryRepair;

  /// No description provided for @categoryRenovation.
  ///
  /// In en, this message translates to:
  /// **'Renovation'**
  String get categoryRenovation;

  /// No description provided for @categoryMoving.
  ///
  /// In en, this message translates to:
  /// **'Moving'**
  String get categoryMoving;

  /// No description provided for @allServices.
  ///
  /// In en, this message translates to:
  /// **'All services'**
  String get allServices;

  /// No description provided for @servicesCountPayOnSite.
  ///
  /// In en, this message translates to:
  /// **'{count} services · pay on site'**
  String servicesCountPayOnSite(int count);

  /// No description provided for @noMatchingServices.
  ///
  /// In en, this message translates to:
  /// **'No matching services.'**
  String get noMatchingServices;

  /// No description provided for @serviceDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceDetailTitle;

  /// No description provided for @serviceMissing.
  ///
  /// In en, this message translates to:
  /// **'This service is unavailable.'**
  String get serviceMissing;

  /// No description provided for @payOnSite.
  ///
  /// In en, this message translates to:
  /// **'Pay on site'**
  String get payOnSite;

  /// No description provided for @durationPricePayOnSite.
  ///
  /// In en, this message translates to:
  /// **'{duration} · {price} · pay on site'**
  String durationPricePayOnSite(String duration, String price);

  /// No description provided for @serviceIncludes.
  ///
  /// In en, this message translates to:
  /// **'What\'s included'**
  String get serviceIncludes;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @providerMissing.
  ///
  /// In en, this message translates to:
  /// **'Provider details unavailable.'**
  String get providerMissing;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book now · {price}'**
  String bookNow(String price);

  /// No description provided for @bookTitle.
  ///
  /// In en, this message translates to:
  /// **'Book service'**
  String get bookTitle;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select a time · {date}'**
  String selectTime(String date);

  /// No description provided for @visitAddress.
  ///
  /// In en, this message translates to:
  /// **'Visit address'**
  String get visitAddress;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the visit address'**
  String get addressHint;

  /// No description provided for @defaultAddressHint.
  ///
  /// In en, this message translates to:
  /// **'88 Demo Rd, Wuhua, Kunming'**
  String get defaultAddressHint;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Gate code, contact, etc.'**
  String get notesHint;

  /// No description provided for @slotNotSelected.
  ///
  /// In en, this message translates to:
  /// **'No time selected'**
  String get slotNotSelected;

  /// No description provided for @bookingSummary.
  ///
  /// In en, this message translates to:
  /// **'Total {price} · {slot} · pay on site'**
  String bookingSummary(String price, String slot);

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting…'**
  String get submitting;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm booking · {price}'**
  String confirmBooking(String price);

  /// No description provided for @selectTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Please select a time slot.'**
  String get selectTimeSlot;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter the visit address.'**
  String get enterAddress;

  /// No description provided for @slotUnavailable.
  ///
  /// In en, this message translates to:
  /// **'That time is unavailable. Pick another.'**
  String get slotUnavailable;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get myBookings;

  /// No description provided for @bookingsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet.'**
  String get bookingsEmpty;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @bookingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking details'**
  String get bookingDetailTitle;

  /// No description provided for @bookingMissing.
  ///
  /// In en, this message translates to:
  /// **'This booking was not found.'**
  String get bookingMissing;

  /// No description provided for @statusTracking.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusTracking;

  /// No description provided for @bookingCancelledBanner.
  ///
  /// In en, this message translates to:
  /// **'This booking was cancelled.'**
  String get bookingCancelledBanner;

  /// No description provided for @labelTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get labelTime;

  /// No description provided for @labelAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get labelAddress;

  /// No description provided for @labelNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get labelNotes;

  /// No description provided for @labelPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get labelPayment;

  /// No description provided for @labelMyReview.
  ///
  /// In en, this message translates to:
  /// **'My review'**
  String get labelMyReview;

  /// No description provided for @reviewStars.
  ///
  /// In en, this message translates to:
  /// **'{rating} stars'**
  String reviewStars(int rating);

  /// No description provided for @contactProvider.
  ///
  /// In en, this message translates to:
  /// **'Contact provider'**
  String get contactProvider;

  /// No description provided for @contactUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Contact is unavailable right now.'**
  String get contactUnavailable;

  /// No description provided for @durationDays.
  ///
  /// In en, this message translates to:
  /// **'{count}d'**
  String durationDays(int count);

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String durationHours(int count);

  /// No description provided for @durationMinutesLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String durationMinutesLabel(int count);

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get writeReview;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get cancelBooking;

  /// No description provided for @cancelBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this booking?'**
  String get cancelBookingTitle;

  /// No description provided for @cancelBookingBody.
  ///
  /// In en, this message translates to:
  /// **'Cancelled bookings cannot be restored.'**
  String get cancelBookingBody;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @confirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Confirm cancel'**
  String get confirmCancel;

  /// No description provided for @bookingCancelledSnack.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled.'**
  String get bookingCancelledSnack;

  /// No description provided for @reviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewTitle;

  /// No description provided for @reviewServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Review the service'**
  String get reviewServiceTitle;

  /// No description provided for @reviewAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'This booking already has a review.'**
  String get reviewAlreadySubmitted;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @commentOptional.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get commentOptional;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'How was the service?'**
  String get commentHint;

  /// No description provided for @submitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit review'**
  String get submitReview;

  /// No description provided for @reviewSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted.'**
  String get reviewSubmitted;

  /// No description provided for @providerHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider dashboard'**
  String get providerHomeTitle;

  /// No description provided for @switchToProviderRole.
  ///
  /// In en, this message translates to:
  /// **'Switch to provider'**
  String get switchToProviderRole;

  /// No description provided for @providerProfile.
  ///
  /// In en, this message translates to:
  /// **'Provider profile'**
  String get providerProfile;

  /// No description provided for @inProgressCompletedCount.
  ///
  /// In en, this message translates to:
  /// **'{active} in progress · {completed} completed'**
  String inProgressCompletedCount(int active, int completed);

  /// No description provided for @newBookings.
  ///
  /// In en, this message translates to:
  /// **'New bookings'**
  String get newBookings;

  /// No description provided for @noPendingBookings.
  ///
  /// In en, this message translates to:
  /// **'No pending bookings.'**
  String get noPendingBookings;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get reject;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @myActive.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get myActive;

  /// No description provided for @noActiveBookings.
  ///
  /// In en, this message translates to:
  /// **'No bookings in progress.'**
  String get noActiveBookings;

  /// No description provided for @startService.
  ///
  /// In en, this message translates to:
  /// **'Start service'**
  String get startService;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @availableHours.
  ///
  /// In en, this message translates to:
  /// **'Available hours'**
  String get availableHours;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @signInOrSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign in / Sign up'**
  String get signInOrSignUp;

  /// No description provided for @signInToSaveBookings.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save bookings'**
  String get signInToSaveBookings;

  /// No description provided for @signedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get signedIn;

  /// No description provided for @guestSession.
  ///
  /// In en, this message translates to:
  /// **'Guest session'**
  String get guestSession;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get syncNow;

  /// No description provided for @syncRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Bookings and reviews refreshed.'**
  String get syncRefreshed;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @currentRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get currentRole;

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get roleUser;

  /// No description provided for @roleProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get roleProvider;

  /// No description provided for @roleHint.
  ///
  /// In en, this message translates to:
  /// **'Switch roles in this app to take bookings as a provider.'**
  String get roleHint;

  /// No description provided for @providerWorkbench.
  ///
  /// In en, this message translates to:
  /// **'Provider dashboard'**
  String get providerWorkbench;

  /// No description provided for @providerWorkbenchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Accept and advance bookings'**
  String get providerWorkbenchSubtitle;

  /// No description provided for @switchToProvider.
  ///
  /// In en, this message translates to:
  /// **'Switch to Provider'**
  String get switchToProvider;

  /// No description provided for @switchToProviderHint.
  ///
  /// In en, this message translates to:
  /// **'Then open the dashboard to take jobs.'**
  String get switchToProviderHint;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentPayOnSite.
  ///
  /// In en, this message translates to:
  /// **'Pay on site / cash'**
  String get paymentPayOnSite;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to HomeBook'**
  String get welcomeTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync bookings and reviews.'**
  String get signInSubtitle;

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

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get signingIn;

  /// No description provided for @noAccountSignUp.
  ///
  /// In en, this message translates to:
  /// **'No account? Sign up'**
  String get noAccountSignUp;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpTitle;

  /// No description provided for @joinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join HomeBook'**
  String get joinTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to save bookings and reviews.'**
  String get signUpSubtitle;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating account…'**
  String get creatingAccount;

  /// No description provided for @haveAccountSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get haveAccountSignIn;

  /// No description provided for @authEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email.'**
  String get authEmailRequired;

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get authPasswordRequired;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {min} characters.'**
  String authPasswordTooShort(int min);
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
