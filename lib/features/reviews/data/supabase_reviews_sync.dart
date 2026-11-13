import 'package:homebook_app/features/reviews/domain/review.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseReviewsSync {
  SupabaseReviewsSync(this._client);

  final SupabaseClient _client;

  String? get _userId => _client.auth.currentUser?.id;

  bool get isSignedIn => _userId != null;

  Future<List<Review>> pullMine() async {
    final userId = _userId;
    if (userId == null) return const [];

    final rows = await _client
        .from('reviews')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return [
      for (final row in rows as List<dynamic>)
        _map(Map<String, dynamic>.from(row as Map)),
    ];
  }

  Future<void> pushReview(Review review) async {
    final userId = _userId;
    if (userId == null) return;

    await _client.from('reviews').upsert({
      'id': review.id,
      'booking_id': review.bookingId,
      'user_id': userId,
      'provider_id': review.providerId,
      'rating': review.rating,
      'comment': review.comment,
      'created_at': review.createdAt.toUtc().toIso8601String(),
    });
  }

  Review _map(Map<String, dynamic> row) {
    return Review(
      id: row['id'] as String,
      bookingId: row['booking_id'] as String? ?? '',
      userId: row['user_id'] as String? ?? '',
      providerId: row['provider_id'] as String? ?? '',
      rating: (row['rating'] as num?)?.toInt() ?? 5,
      comment: row['comment'] as String? ?? '',
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ??
          DateTime.now().toUtc(),
    );
  }
}
