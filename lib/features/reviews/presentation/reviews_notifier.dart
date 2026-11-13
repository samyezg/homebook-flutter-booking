import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/reviews/data/mock_reviews_repository.dart';
import 'package:homebook_app/features/reviews/domain/review.dart';
import 'package:homebook_app/features/reviews/domain/reviews_repository.dart';
import 'package:homebook_app/features/services/presentation/services_providers.dart';
import 'package:homebook_app/features/session/active_user_id.dart';

final reviewsRepositoryProvider = Provider<ReviewsRepository>((ref) {
  return MockReviewsRepository();
});

class ReviewsNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void _bump() => state++;

  Review submit({
    required String bookingId,
    required int rating,
    String comment = '',
  }) {
    final booking = ref.read(bookingsRepositoryProvider).getBooking(bookingId);
    if (booking == null) {
      throw const ReviewException('Booking not found');
    }
    if (booking.status != BookingStatus.completed) {
      throw const ReviewException('Only completed bookings can be reviewed');
    }

    final review = ref.read(reviewsRepositoryProvider).createReview(
          bookingId: bookingId,
          userId: ref.read(activeUserIdProvider),
          providerId: booking.providerId,
          rating: rating,
          comment: comment,
        );
    ref
        .read(servicesRepositoryProvider)
        .applyReviewRating(booking.providerId, rating);
    ref.read(catalogRevisionProvider.notifier).bump();
    _bump();
    return review;
  }
}

final reviewsProvider =
    NotifierProvider<ReviewsNotifier, int>(ReviewsNotifier.new);

final reviewByBookingIdProvider = Provider.family<Review?, String>((ref, id) {
  ref.watch(reviewsProvider);
  return ref.watch(reviewsRepositoryProvider).getByBookingId(id);
});
