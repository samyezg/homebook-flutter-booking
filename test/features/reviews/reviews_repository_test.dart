import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/reviews/data/mock_reviews_repository.dart';
import 'package:homebook_app/features/reviews/domain/reviews_repository.dart';
import 'package:homebook_app/features/services/data/mock_services_repository.dart';

void main() {
  test('review is one-per-booking and updates provider average', () {
    final bookings = MockBookingsRepository();
    final reviews = MockReviewsRepository();
    final services = MockServicesRepository();

    final done = bookings.getBooking('bk-seed-done')!;
    expect(done.status, BookingStatus.completed);

    final before = services.getProvider(done.providerId)!;
    final review = reviews.createReview(
      bookingId: done.id,
      userId: 'user-demo',
      providerId: done.providerId,
      rating: 5,
      comment: '很好',
    );
    expect(review.rating, 5);

    expect(
      () => reviews.createReview(
        bookingId: done.id,
        userId: 'user-demo',
        providerId: done.providerId,
        rating: 4,
      ),
      throwsA(isA<ReviewException>()),
    );

    final after = services.applyReviewRating(done.providerId, 5);
    expect(after.ratingCount, before.ratingCount + 1);
  });
}
