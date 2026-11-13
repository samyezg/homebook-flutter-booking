import 'package:homebook_app/features/reviews/domain/review.dart';
import 'package:homebook_app/features/reviews/domain/reviews_repository.dart';

class MockReviewsRepository implements ReviewsRepository {
  MockReviewsRepository({List<Review>? seed}) : _reviews = [...?seed];

  final List<Review> _reviews;
  var _seq = 0;

  List<Review> all() => List.unmodifiable(_reviews);

  void replaceAll(List<Review> items) {
    _reviews
      ..clear()
      ..addAll(items);
  }

  @override
  Review? getByBookingId(String bookingId) {
    for (final review in _reviews) {
      if (review.bookingId == bookingId) return review;
    }
    return null;
  }

  @override
  List<Review> listForProvider(String providerId) {
    return [
      for (final review in _reviews)
        if (review.providerId == providerId) review,
    ];
  }

  @override
  Review createReview({
    required String bookingId,
    required String userId,
    required String providerId,
    required int rating,
    String comment = '',
  }) {
    if (rating < 1 || rating > 5) {
      throw const ReviewException('Rating must be between 1 and 5');
    }
    if (getByBookingId(bookingId) != null) {
      throw const ReviewException('This booking already has a review');
    }
    _seq += 1;
    final review = Review(
      id: 'rv-${DateTime.now().microsecondsSinceEpoch}-$_seq',
      bookingId: bookingId,
      userId: userId,
      providerId: providerId,
      rating: rating,
      comment: comment.trim(),
      createdAt: DateTime.now().toUtc(),
    );
    _reviews.add(review);
    return review;
  }
}
