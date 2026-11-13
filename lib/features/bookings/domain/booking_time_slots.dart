/// Fixed MVP slots (local wall clock hours).
abstract final class BookingTimeSlots {
  static const hours = <int>[9, 10, 14, 15, 16, 18];

  static String label(int hour) =>
      '${hour.toString().padLeft(2, '0')}:00';

  static DateTime combine(DateTime day, int hour) {
    return DateTime(day.year, day.month, day.day, hour);
  }

  static bool isDaySelectable(DateTime day, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final today = DateTime(current.year, current.month, current.day);
    final candidate = DateTime(day.year, day.month, day.day);
    return !candidate.isBefore(today);
  }

  static bool isSlotSelectable(DateTime day, int hour, {DateTime? now}) {
    if (!isDaySelectable(day, now: now)) return false;
    final current = now ?? DateTime.now();
    final today = DateTime(current.year, current.month, current.day);
    final candidateDay = DateTime(day.year, day.month, day.day);
    if (candidateDay.isAfter(today)) return true;
    return hour > current.hour;
  }

  static int? firstSelectableHour(DateTime day, {DateTime? now}) {
    for (final hour in hours) {
      if (isSlotSelectable(day, hour, now: now)) return hour;
    }
    return null;
  }
}
