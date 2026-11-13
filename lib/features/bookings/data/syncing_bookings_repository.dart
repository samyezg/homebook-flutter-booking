import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/data/supabase_bookings_sync.dart';
import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';

/// Local-first bookings: Mock memory + best-effort Supabase push/pull.
class SyncingBookingsRepository implements BookingsRepository {
  SyncingBookingsRepository({
    required this.local,
    this.sync,
  });

  final MockBookingsRepository local;
  final SupabaseBookingsSync? sync;

  Future<void> pullAndMerge() async {
    final cloud = sync;
    if (cloud == null || !cloud.isSignedIn) return;
    try {
      final remote = await cloud.pullMine();
      final byId = <String, Booking>{
        for (final booking in local.listBookings()) booking.id: booking,
      };
      for (final booking in remote) {
        byId[booking.id] = booking;
      }
      local.replaceAll(byId.values.toList());
      for (final booking in byId.values) {
        await cloud.pushBooking(booking);
      }
    } catch (_) {
      // Keep local on network/RLS failures.
    }
  }

  Future<void> _push(Booking booking) async {
    final cloud = sync;
    if (cloud == null || !cloud.isSignedIn) return;
    try {
      await cloud.pushBooking(booking);
    } catch (_) {}
  }

  @override
  List<Booking> listBookings({BookingStatus? status}) =>
      local.listBookings(status: status);

  @override
  List<Booking> listForProvider(String providerId, {BookingStatus? status}) =>
      local.listForProvider(providerId, status: status);

  @override
  Booking? getBooking(String id) => local.getBooking(id);

  @override
  Booking createBooking({
    required String userId,
    required String providerId,
    required String serviceId,
    required String serviceName,
    required DateTime scheduledAt,
    required String address,
    required int totalCents,
    String notes = '',
  }) {
    final created = local.createBooking(
      userId: userId,
      providerId: providerId,
      serviceId: serviceId,
      serviceName: serviceName,
      scheduledAt: scheduledAt,
      address: address,
      totalCents: totalCents,
      notes: notes,
    );
    // ignore: discarded_futures
    _push(created);
    return created;
  }

  @override
  Booking? updateStatus(String id, BookingStatus status) {
    final updated = local.updateStatus(id, status);
    if (updated != null) {
      // ignore: discarded_futures
      _push(updated);
    }
    return updated;
  }

  @override
  Booking cancelBooking(String id) {
    final booking = local.cancelBooking(id);
    // ignore: discarded_futures
    _push(booking);
    return booking;
  }

  @override
  Booking acceptBooking(String id) {
    final booking = local.acceptBooking(id);
    // ignore: discarded_futures
    _push(booking);
    return booking;
  }

  @override
  Booking rejectBooking(String id) {
    final booking = local.rejectBooking(id);
    // ignore: discarded_futures
    _push(booking);
    return booking;
  }

  @override
  Booking startBooking(String id) {
    final booking = local.startBooking(id);
    // ignore: discarded_futures
    _push(booking);
    return booking;
  }

  @override
  Booking completeBooking(String id) {
    final booking = local.completeBooking(id);
    // ignore: discarded_futures
    _push(booking);
    return booking;
  }
}
