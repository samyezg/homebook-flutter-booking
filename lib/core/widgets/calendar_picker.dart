import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/features/bookings/domain/booking_time_slots.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPicker extends StatelessWidget {
  const CalendarPicker({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, now.day);
    final last = DateTime(now.year, now.month + 3, now.day);

    return TableCalendar(
      key: const ValueKey('booking-calendar'),
      locale: Localizations.localeOf(context).toString(),
      firstDay: first,
      lastDay: last,
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      calendarFormat: CalendarFormat.month,
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.primary,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.primaryLight.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        disabledTextStyle: const TextStyle(color: AppColors.border),
      ),
      enabledDayPredicate: (day) => BookingTimeSlots.isDaySelectable(day),
      onDaySelected: onDaySelected,
    );
  }
}
