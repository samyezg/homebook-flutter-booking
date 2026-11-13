import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/bookings/domain/booking_time_slots.dart';

void main() {
  test('rejects past days and past hours on today', () {
    final now = DateTime(2026, 11, 10, 11, 30);
    final yesterday = DateTime(2026, 11, 9);
    final today = DateTime(2026, 11, 10);
    final tomorrow = DateTime(2026, 11, 11);

    expect(BookingTimeSlots.isDaySelectable(yesterday, now: now), isFalse);
    expect(BookingTimeSlots.isDaySelectable(today, now: now), isTrue);
    expect(BookingTimeSlots.isSlotSelectable(today, 10, now: now), isFalse);
    expect(BookingTimeSlots.isSlotSelectable(today, 14, now: now), isTrue);
    expect(BookingTimeSlots.isSlotSelectable(tomorrow, 9, now: now), isTrue);
    expect(BookingTimeSlots.firstSelectableHour(today, now: now), 14);
  });
}
