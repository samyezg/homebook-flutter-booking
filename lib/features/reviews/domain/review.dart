class Review {
  const Review({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.providerId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final String id;
  final String bookingId;
  final String userId;
  final String providerId;
  final int rating;
  final String comment;
  final DateTime createdAt;
}
