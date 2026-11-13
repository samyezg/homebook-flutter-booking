import 'package:homebook_app/features/bookings/domain/booking_status.dart';

class Booking {
  const Booking({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceId,
    required this.serviceName,
    required this.scheduledAt,
    required this.status,
    required this.address,
    required this.totalCents,
    required this.createdAt,
    this.notes = '',
    this.payNote = 'Pay on site / cash',
  });

  final String id;
  final String userId;
  final String providerId;
  final String serviceId;
  final String serviceName;
  final DateTime scheduledAt;
  final BookingStatus status;
  final String address;
  final String notes;
  final int totalCents;
  final String payNote;
  final DateTime createdAt;

  String get priceLabel => '¥${(totalCents / 100).toStringAsFixed(0)}';

  Booking copyWith({
    BookingStatus? status,
    String? address,
    String? notes,
  }) {
    return Booking(
      id: id,
      userId: userId,
      providerId: providerId,
      serviceId: serviceId,
      serviceName: serviceName,
      scheduledAt: scheduledAt,
      status: status ?? this.status,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      totalCents: totalCents,
      payNote: payNote,
      createdAt: createdAt,
    );
  }
}
