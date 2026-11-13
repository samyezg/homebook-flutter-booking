import 'package:homebook_app/features/bookings/data/mock_bookings_seed.dart';
import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';

class MockBookingsRepository implements BookingsRepository {
  MockBookingsRepository({List<Booking>? seed})
      : _bookings = [...(seed ?? MockBookingsSeed.demo())];

  final List<Booking> _bookings;
  var _seq = 0;

  void replaceAll(List<Booking> items) {
    _bookings
      ..clear()
      ..addAll(items);
  }

  @override
  List<Booking> listBookings({BookingStatus? status}) {
    final items = [
      for (final booking in _bookings)
        if (status == null || booking.status == status) booking,
    ];
    items.sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
    return items;
  }

  @override
  List<Booking> listForProvider(String providerId, {BookingStatus? status}) {
    return [
      for (final booking in listBookings(status: status))
        if (booking.providerId == providerId) booking,
    ];
  }

  @override
  Booking? getBooking(String id) {
    for (final booking in _bookings) {
      if (booking.id == id) return booking;
    }
    return null;
  }

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
    final trimmed = address.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Address is required');
    }
    _seq += 1;
    final booking = Booking(
      id: 'bk-${DateTime.now().microsecondsSinceEpoch}-$_seq',
      userId: userId,
      providerId: providerId,
      serviceId: serviceId,
      serviceName: serviceName,
      scheduledAt: scheduledAt,
      status: BookingStatus.pending,
      address: trimmed,
      notes: notes.trim(),
      totalCents: totalCents,
      createdAt: DateTime.now().toUtc(),
    );
    _bookings.insert(0, booking);
    return booking;
  }

  @override
  Booking? updateStatus(String id, BookingStatus status) {
    final index = _bookings.indexWhere((b) => b.id == id);
    if (index < 0) return null;
    final updated = _bookings[index].copyWith(status: status);
    _bookings[index] = updated;
    return updated;
  }

  Booking _require(String id) {
    final booking = getBooking(id);
    if (booking == null) {
      throw const BookingException('Booking not found');
    }
    return booking;
  }

  Booking _transition(String id, BookingStatus from, BookingStatus to) {
    final booking = _require(id);
    if (booking.status != from) {
      throw BookingException('Only ${from.id} can transition to ${to.id}');
    }
    return updateStatus(id, to)!;
  }

  @override
  Booking cancelBooking(String id) {
    final booking = _require(id);
    if (!booking.status.canCancel) {
      throw const BookingException('Cannot cancel in the current status');
    }
    return updateStatus(id, BookingStatus.cancelled)!;
  }

  @override
  Booking acceptBooking(String id) =>
      _transition(id, BookingStatus.pending, BookingStatus.accepted);

  @override
  Booking rejectBooking(String id) =>
      _transition(id, BookingStatus.pending, BookingStatus.cancelled);

  @override
  Booking startBooking(String id) =>
      _transition(id, BookingStatus.accepted, BookingStatus.inProgress);

  @override
  Booking completeBooking(String id) =>
      _transition(id, BookingStatus.inProgress, BookingStatus.completed);
}
