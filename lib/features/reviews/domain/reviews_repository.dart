import 'package:homebook_app/features/reviews/domain/review.dart';

class ReviewException implements Exception {
  const ReviewException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class ReviewsRepository {
  Review? getByBookingId(String bookingId);

  List<Review> listForProvider(String providerId);

  Review createReview({
    required String bookingId,
    required String userId,
    required String providerId,
    required int rating,
    String comment = '',
  });
}
