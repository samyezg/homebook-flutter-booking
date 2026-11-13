import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class BookingStatusChip extends StatelessWidget {
  const BookingStatusChip({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('status-${status.id}'),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        context.l10n.bookingStatusLabel(status),
        style: TextStyle(
          fontFamily: AppFonts.secondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: status.color,
        ),
      ),
    );
  }
}
