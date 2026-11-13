import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBookingsSync {
  SupabaseBookingsSync(this._client);

  final SupabaseClient _client;

  String? get _userId => _client.auth.currentUser?.id;

  bool get isSignedIn => _userId != null;

  Future<List<Booking>> pullMine() async {
    final userId = _userId;
    if (userId == null) return const [];

    final rows = await _client
        .from('bookings')
        .select()
        .eq('user_id', userId)
        .order('scheduled_at', ascending: false);

    return [
      for (final row in rows as List<dynamic>)
        _map(Map<String, dynamic>.from(row as Map)),
    ];
  }

  Future<void> pushBooking(Booking booking) async {
    final userId = _userId;
    if (userId == null) return;

    await _client.from('bookings').upsert({
      'id': booking.id,
      'user_id': userId,
      'provider_id': booking.providerId,
      'service_id': booking.serviceId,
      'service_name': booking.serviceName,
      'scheduled_at': booking.scheduledAt.toUtc().toIso8601String(),
      'status': booking.status.id,
      'address': booking.address,
      'notes': booking.notes,
      'total_cents': booking.totalCents,
      'created_at': booking.createdAt.toUtc().toIso8601String(),
    });
  }

  Booking _map(Map<String, dynamic> row) {
    final statusId = row['status'] as String? ?? 'pending';
    return Booking(
      id: row['id'] as String,
      userId: row['user_id'] as String? ?? '',
      providerId: row['provider_id'] as String? ?? '',
      serviceId: row['service_id'] as String? ?? '',
      serviceName: row['service_name'] as String? ?? '',
      scheduledAt: DateTime.tryParse(row['scheduled_at'] as String? ?? '') ??
          DateTime.now(),
      status: BookingStatus.values.firstWhere(
        (s) => s.id == statusId,
        orElse: () => BookingStatus.pending,
      ),
      address: row['address'] as String? ?? '',
      notes: row['notes'] as String? ?? '',
      totalCents: (row['total_cents'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ??
          DateTime.now().toUtc(),
    );
  }
}
