import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';
import 'package:homebook_app/features/profile/presentation/role_notifier.dart';
import 'package:homebook_app/features/session/active_user_id.dart';

final bookingsRepositoryProvider = Provider<BookingsRepository>((ref) {
  return MockBookingsRepository();
});

class BookingsNotifier extends Notifier<List<Booking>> {
  @override
  List<Booking> build() {
    return ref.watch(bookingsRepositoryProvider).listBookings();
  }

  void _reload() {
    state = ref.read(bookingsRepositoryProvider).listBookings();
  }

  Booking create({
    required String providerId,
    required String serviceId,
    required String serviceName,
    required DateTime scheduledAt,
    required String address,
    required int totalCents,
    String notes = '',
  }) {
    final booking = ref.read(bookingsRepositoryProvider).createBooking(
          userId: ref.read(activeUserIdProvider),
          providerId: providerId,
          serviceId: serviceId,
          serviceName: serviceName,
          scheduledAt: scheduledAt,
          address: address,
          totalCents: totalCents,
          notes: notes,
        );
    _reload();
    return booking;
  }

  void setStatus(String id, BookingStatus status) {
    ref.read(bookingsRepositoryProvider).updateStatus(id, status);
    _reload();
  }

  Booking cancel(String id) {
    final booking = ref.read(bookingsRepositoryProvider).cancelBooking(id);
    _reload();
    return booking;
  }

  Booking accept(String id) {
    final booking = ref.read(bookingsRepositoryProvider).acceptBooking(id);
    _reload();
    return booking;
  }

  Booking reject(String id) {
    final booking = ref.read(bookingsRepositoryProvider).rejectBooking(id);
    _reload();
    return booking;
  }

  Booking start(String id) {
    final booking = ref.read(bookingsRepositoryProvider).startBooking(id);
    _reload();
    return booking;
  }

  Booking complete(String id) {
    final booking = ref.read(bookingsRepositoryProvider).completeBooking(id);
    _reload();
    return booking;
  }
}

final bookingsProvider =
    NotifierProvider<BookingsNotifier, List<Booking>>(BookingsNotifier.new);

final bookingByIdProvider = Provider.family<Booking?, String>((ref, id) {
  ref.watch(bookingsProvider);
  return ref.watch(bookingsRepositoryProvider).getBooking(id);
});

class BookingListFilterNotifier extends Notifier<BookingStatus?> {
  @override
  BookingStatus? build() => null;

  void setFilter(BookingStatus? status) => state = status;
}

final bookingListFilterProvider =
    NotifierProvider<BookingListFilterNotifier, BookingStatus?>(
  BookingListFilterNotifier.new,
);

final filteredBookingsProvider = Provider<List<Booking>>((ref) {
  final all = ref.watch(bookingsProvider);
  final filter = ref.watch(bookingListFilterProvider);
  if (filter == null) return all;
  return [for (final b in all) if (b.status == filter) b];
});

final providerPendingBookingsProvider = Provider<List<Booking>>((ref) {
  ref.watch(bookingsProvider);
  final providerId = ref.watch(activeProviderIdProvider);
  return ref
      .watch(bookingsRepositoryProvider)
      .listForProvider(providerId, status: BookingStatus.pending);
});

final providerActiveBookingsProvider = Provider<List<Booking>>((ref) {
  ref.watch(bookingsProvider);
  final providerId = ref.watch(activeProviderIdProvider);
  final repo = ref.watch(bookingsRepositoryProvider);
  return [
    ...repo.listForProvider(providerId, status: BookingStatus.accepted),
    ...repo.listForProvider(providerId, status: BookingStatus.inProgress),
  ];
});
