import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/data/syncing_bookings_repository.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';

void main() {
  test('syncing repo delegates create and status without cloud', () {
    final local = MockBookingsRepository(seed: const []);
    final repo = SyncingBookingsRepository(local: local);

    final created = repo.createBooking(
      userId: 'u1',
      providerId: 'prov-li',
      serviceId: 'svc-pipe-repair',
      serviceName: 'Plumbing Repair',
      scheduledAt: DateTime(2026, 11, 12, 10),
      address: 'Kunming',
      totalCents: 12000,
    );
    expect(created.status, BookingStatus.pending);
    expect(repo.acceptBooking(created.id).status, BookingStatus.accepted);
    expect(local.getBooking(created.id)?.status, BookingStatus.accepted);
  });
}
