import 'package:homebook_app/features/reviews/data/mock_reviews_repository.dart';
import 'package:homebook_app/features/reviews/data/supabase_reviews_sync.dart';
import 'package:homebook_app/features/reviews/domain/review.dart';
import 'package:homebook_app/features/reviews/domain/reviews_repository.dart';

class SyncingReviewsRepository implements ReviewsRepository {
  SyncingReviewsRepository({
    required this.local,
    this.sync,
  });

  final MockReviewsRepository local;
  final SupabaseReviewsSync? sync;

  Future<void> pullAndMerge() async {
    final cloud = sync;
    if (cloud == null || !cloud.isSignedIn) return;
    try {
      final remote = await cloud.pullMine();
      final byBooking = <String, Review>{
        for (final review in local.all()) review.bookingId: review,
      };
      for (final review in remote) {
        byBooking[review.bookingId] = review;
      }
      local.replaceAll(byBooking.values.toList());
      for (final review in byBooking.values) {
        await cloud.pushReview(review);
      }
    } catch (_) {}
  }

  Future<void> _push(Review review) async {
    final cloud = sync;
    if (cloud == null || !cloud.isSignedIn) return;
    try {
      await cloud.pushReview(review);
    } catch (_) {}
  }

  @override
  Review? getByBookingId(String bookingId) => local.getByBookingId(bookingId);

  @override
  List<Review> listForProvider(String providerId) =>
      local.listForProvider(providerId);

  @override
  Review createReview({
    required String bookingId,
    required String userId,
    required String providerId,
    required int rating,
    String comment = '',
  }) {
    final created = local.createReview(
      bookingId: bookingId,
      userId: userId,
      providerId: providerId,
      rating: rating,
      comment: comment,
    );
    // ignore: discarded_futures
    _push(created);
    return created;
  }
}
