abstract final class AppRoutes {
  static const home = '/';
  static const serviceDetail = '/service/:id';
  static const book = '/book/:id';
  static const bookings = '/bookings';
  static const bookingDetail = '/booking/:id';
  static const bookingReview = '/booking/:id/review';
  static const profile = '/profile';
  static const providerHome = '/provider/home';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';

  static String serviceDetailLocation(String id) => '/service/$id';
  static String bookLocation(String id) => '/book/$id';
  static String bookingDetailLocation(String id) => '/booking/$id';
  static String bookingReviewLocation(String id) => '/booking/$id/review';
}
