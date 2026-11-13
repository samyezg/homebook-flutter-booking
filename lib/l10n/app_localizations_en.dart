// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HomeBook';

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navProfile => 'Profile';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get searchServicesHint => 'Search services…';

  @override
  String get categories => 'Categories';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryCleaning => 'Cleaning';

  @override
  String get categoryRepair => 'Repair';

  @override
  String get categoryRenovation => 'Renovation';

  @override
  String get categoryMoving => 'Moving';

  @override
  String get allServices => 'All services';

  @override
  String servicesCountPayOnSite(int count) {
    return '$count services · pay on site';
  }

  @override
  String get noMatchingServices => 'No matching services.';

  @override
  String get serviceDetailTitle => 'Service';

  @override
  String get serviceMissing => 'This service is unavailable.';

  @override
  String get payOnSite => 'Pay on site';

  @override
  String durationPricePayOnSite(String duration, String price) {
    return '$duration · $price · pay on site';
  }

  @override
  String get serviceIncludes => 'What\'s included';

  @override
  String get provider => 'Provider';

  @override
  String get providerMissing => 'Provider details unavailable.';

  @override
  String bookNow(String price) {
    return 'Book now · $price';
  }

  @override
  String get bookTitle => 'Book service';

  @override
  String get selectDate => 'Select a date';

  @override
  String selectTime(String date) {
    return 'Select a time · $date';
  }

  @override
  String get visitAddress => 'Visit address';

  @override
  String get addressHint => 'Enter the visit address';

  @override
  String get defaultAddressHint => '88 Demo Rd, Wuhua, Kunming';

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String get notesHint => 'Gate code, contact, etc.';

  @override
  String get slotNotSelected => 'No time selected';

  @override
  String bookingSummary(String price, String slot) {
    return 'Total $price · $slot · pay on site';
  }

  @override
  String get submitting => 'Submitting…';

  @override
  String confirmBooking(String price) {
    return 'Confirm booking · $price';
  }

  @override
  String get selectTimeSlot => 'Please select a time slot.';

  @override
  String get enterAddress => 'Please enter the visit address.';

  @override
  String get slotUnavailable => 'That time is unavailable. Pick another.';

  @override
  String get myBookings => 'My bookings';

  @override
  String get bookingsEmpty => 'No bookings yet.';

  @override
  String get filterAll => 'All';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusInProgress => 'In progress';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get bookingDetailTitle => 'Booking details';

  @override
  String get bookingMissing => 'This booking was not found.';

  @override
  String get statusTracking => 'Status';

  @override
  String get bookingCancelledBanner => 'This booking was cancelled.';

  @override
  String get labelTime => 'Time';

  @override
  String get labelAddress => 'Address';

  @override
  String get labelNotes => 'Notes';

  @override
  String get labelPayment => 'Payment';

  @override
  String get labelMyReview => 'My review';

  @override
  String reviewStars(int rating) {
    return '$rating stars';
  }

  @override
  String get contactProvider => 'Contact provider';

  @override
  String get contactUnavailable => 'Contact is unavailable right now.';

  @override
  String durationDays(int count) {
    return '${count}d';
  }

  @override
  String durationHours(int count) {
    return '${count}h';
  }

  @override
  String durationMinutesLabel(int count) {
    return '$count min';
  }

  @override
  String get writeReview => 'Write a review';

  @override
  String get cancelBooking => 'Cancel booking';

  @override
  String get cancelBookingTitle => 'Cancel this booking?';

  @override
  String get cancelBookingBody => 'Cancelled bookings cannot be restored.';

  @override
  String get back => 'Back';

  @override
  String get confirmCancel => 'Confirm cancel';

  @override
  String get bookingCancelledSnack => 'Booking cancelled.';

  @override
  String get reviewTitle => 'Review';

  @override
  String get reviewServiceTitle => 'Review the service';

  @override
  String get reviewAlreadySubmitted => 'This booking already has a review.';

  @override
  String get rating => 'Rating';

  @override
  String get commentOptional => 'Comment (optional)';

  @override
  String get commentHint => 'How was the service?';

  @override
  String get submitReview => 'Submit review';

  @override
  String get reviewSubmitted => 'Review submitted.';

  @override
  String get providerHomeTitle => 'Provider dashboard';

  @override
  String get switchToProviderRole => 'Switch to provider';

  @override
  String get providerProfile => 'Provider profile';

  @override
  String inProgressCompletedCount(int active, int completed) {
    return '$active in progress · $completed completed';
  }

  @override
  String get newBookings => 'New bookings';

  @override
  String get noPendingBookings => 'No pending bookings.';

  @override
  String get reject => 'Decline';

  @override
  String get accept => 'Accept';

  @override
  String get myActive => 'In progress';

  @override
  String get noActiveBookings => 'No bookings in progress.';

  @override
  String get startService => 'Start service';

  @override
  String get complete => 'Complete';

  @override
  String get availableHours => 'Available hours';

  @override
  String get details => 'Details';

  @override
  String get profileTitle => 'Profile';

  @override
  String get account => 'Account';

  @override
  String get signInOrSignUp => 'Sign in / Sign up';

  @override
  String get signInToSaveBookings => 'Sign in to save bookings';

  @override
  String get signedIn => 'Signed in';

  @override
  String get guestSession => 'Guest session';

  @override
  String get syncNow => 'Refresh';

  @override
  String get syncRefreshed => 'Bookings and reviews refreshed.';

  @override
  String get signOut => 'Sign out';

  @override
  String get currentRole => 'Role';

  @override
  String get roleUser => 'Customer';

  @override
  String get roleProvider => 'Provider';

  @override
  String get roleHint =>
      'Switch roles in this app to take bookings as a provider.';

  @override
  String get providerWorkbench => 'Provider dashboard';

  @override
  String get providerWorkbenchSubtitle => 'Accept and advance bookings';

  @override
  String get switchToProvider => 'Switch to Provider';

  @override
  String get switchToProviderHint => 'Then open the dashboard to take jobs.';

  @override
  String get payment => 'Payment';

  @override
  String get paymentPayOnSite => 'Pay on site / cash';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get welcomeTitle => 'Welcome to HomeBook';

  @override
  String get signInSubtitle => 'Sign in to sync bookings and reviews.';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signingIn => 'Signing in…';

  @override
  String get noAccountSignUp => 'No account? Sign up';

  @override
  String get signUp => 'Sign up';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get joinTitle => 'Join HomeBook';

  @override
  String get signUpSubtitle =>
      'Create an account to save bookings and reviews.';

  @override
  String get creatingAccount => 'Creating account…';

  @override
  String get haveAccountSignIn => 'Already have an account? Sign in';

  @override
  String get authEmailRequired => 'Enter your email.';

  @override
  String get authEmailInvalid => 'Enter a valid email address.';

  @override
  String get authPasswordRequired => 'Enter your password.';

  @override
  String authPasswordTooShort(int min) {
    return 'Password must be at least $min characters.';
  }
}
