import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';

class BookingException implements Exception {
  const BookingException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class BookingsRepository {
  List<Booking> listBookings({BookingStatus? status});

  List<Booking> listForProvider(String providerId, {BookingStatus? status});

  Booking? getBooking(String id);

  Booking createBooking({
    required String userId,
    required String providerId,
    required String serviceId,
    required String serviceName,
    required DateTime scheduledAt,
    required String address,
    required int totalCents,
    String notes = '',
  });

  Booking? updateStatus(String id, BookingStatus status);

  Booking cancelBooking(String id);

  Booking acceptBooking(String id);

  Booking rejectBooking(String id);

  Booking startBooking(String id);

  Booking completeBooking(String id);
}
