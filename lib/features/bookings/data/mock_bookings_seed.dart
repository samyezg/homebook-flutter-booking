import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';

abstract final class MockBookingsSeed {
  static List<Booking> demo({DateTime? now}) {
    final base = now ?? DateTime.now();
    return [
      Booking(
        id: 'bk-seed-pending',
        userId: 'user-demo',
        providerId: 'prov-li',
        serviceId: 'svc-pipe-repair',
        serviceName: 'Plumbing Repair',
        scheduledAt: DateTime(base.year, base.month, base.day + 1, 10),
        status: BookingStatus.pending,
        address: '12 Cuihu Rd, Wuhua, Kunming',
        notes: 'Kitchen leak',
        totalCents: 12000,
        createdAt: base.toUtc(),
      ),
      Booking(
        id: 'bk-seed-accepted',
        userId: 'user-demo',
        providerId: 'prov-zhang',
        serviceId: 'svc-deep-clean',
        serviceName: 'Deep Cleaning',
        scheduledAt: DateTime(base.year, base.month, base.day, 14),
        status: BookingStatus.accepted,
        address: '88 Beijing Rd, Panlong, Kunming',
        totalCents: 8800,
        createdAt: base.toUtc().subtract(const Duration(hours: 6)),
      ),
      Booking(
        id: 'bk-seed-progress',
        userId: 'user-demo',
        providerId: 'prov-chen',
        serviceId: 'svc-moving',
        serviceName: 'Moving Help',
        scheduledAt: DateTime(base.year, base.month, base.day, 9),
        status: BookingStatus.inProgress,
        address: 'Guandu Center → Chenggong University Town',
        totalCents: 30000,
        createdAt: base.toUtc().subtract(const Duration(days: 1)),
      ),
      Booking(
        id: 'bk-seed-done',
        userId: 'user-demo',
        providerId: 'prov-wang',
        serviceId: 'svc-paint',
        serviceName: 'Interior Painting',
        scheduledAt: DateTime(base.year, base.month, base.day - 2, 9),
        status: BookingStatus.completed,
        address: 'Bldg 3, Qianwei West Rd, Xishan',
        notes: 'Master bedroom walls',
        totalCents: 200000,
        createdAt: base.toUtc().subtract(const Duration(days: 3)),
      ),
    ];
  }
}
