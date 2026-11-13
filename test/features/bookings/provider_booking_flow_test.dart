import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';

void main() {
  test('provider can accept → start → complete', () {
    final repo = MockBookingsRepository(seed: const []);
    final created = repo.createBooking(
      userId: 'u1',
      providerId: 'prov-li',
      serviceId: 'svc-pipe-repair',
      serviceName: 'Plumbing Repair',
      scheduledAt: DateTime(2026, 11, 12, 10),
      address: 'Kunming',
      totalCents: 12000,
    );

    expect(repo.acceptBooking(created.id).status, BookingStatus.accepted);
    expect(repo.startBooking(created.id).status, BookingStatus.inProgress);
    expect(repo.completeBooking(created.id).status, BookingStatus.completed);

    expect(
      () => repo.acceptBooking(created.id),
      throwsA(isA<BookingException>()),
    );
  });

  test('reject pending becomes cancelled', () {
    final repo = MockBookingsRepository();
    final rejected = repo.rejectBooking('bk-seed-pending');
    expect(rejected.status, BookingStatus.cancelled);
  });
}
