import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';

void main() {
  test('createBooking starts as pending and requires address', () {
    final repo = MockBookingsRepository(seed: const []);

    expect(
      () => repo.createBooking(
        userId: 'u1',
        providerId: 'p1',
        serviceId: 's1',
        serviceName: 'Deep Cleaning',
        scheduledAt: DateTime(2026, 11, 11, 14),
        address: '   ',
        totalCents: 8800,
      ),
      throwsA(isA<ArgumentError>()),
    );

    final booking = repo.createBooking(
      userId: 'u1',
      providerId: 'p1',
      serviceId: 's1',
      serviceName: 'Deep Cleaning',
      scheduledAt: DateTime(2026, 11, 11, 14),
      address: 'Wuhua, Kunming',
      totalCents: 8800,
      notes: ' doorbell ',
    );

    expect(booking.status, BookingStatus.pending);
    expect(booking.payNote, contains('Pay on site'));
    expect(booking.notes, 'doorbell');
    expect(repo.listBookings(), hasLength(1));
  });

  test('seed demos four statuses; cancel only pending/accepted', () {
    final repo = MockBookingsRepository();
    expect(repo.listBookings(), hasLength(4));
    expect(
      repo.listBookings(status: BookingStatus.pending),
      hasLength(1),
    );

    final cancelled = repo.cancelBooking('bk-seed-pending');
    expect(cancelled.status, BookingStatus.cancelled);

    expect(
      () => repo.cancelBooking('bk-seed-progress'),
      throwsA(isA<BookingException>()),
    );
  });
}
