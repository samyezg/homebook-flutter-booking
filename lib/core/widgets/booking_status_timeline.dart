import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class BookingStatusTimeline extends StatelessWidget {
  const BookingStatusTimeline({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (status == BookingStatus.cancelled) {
      return Container(
        key: const ValueKey('timeline-cancelled'),
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.statusCancelled.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Text(
          l10n.bookingCancelledBanner,
          style: const TextStyle(
            fontFamily: AppFonts.secondary,
            fontWeight: FontWeight.w600,
            color: AppColors.statusCancelled,
          ),
        ),
      );
    }

    final currentIndex = BookingStatus.pipeline.indexOf(status);

    return Column(
      key: const ValueKey('timeline-pipeline'),
      children: [
        for (var i = 0; i < BookingStatus.pipeline.length; i++) ...[
          _TimelineRow(
            label: l10n.bookingStatusLabel(BookingStatus.pipeline[i]),
            active: i <= currentIndex,
            current: i == currentIndex,
            color: BookingStatus.pipeline[i].color,
          ),
          if (i < BookingStatus.pipeline.length - 1)
            Container(
              margin: const EdgeInsets.only(left: 11),
              alignment: Alignment.centerLeft,
              height: 16,
              width: 2,
              color: i < currentIndex
                  ? BookingStatus.pipeline[i].color
                  : AppColors.border,
            ),
        ],
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.label,
    required this.active,
    required this.current,
    required this.color,
  });

  final String label;
  final bool active;
  final bool current;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? color : AppColors.surface,
            border: Border.all(
              color: active ? color : AppColors.border,
              width: 2,
            ),
          ),
          child: active
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : null,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.secondary,
            fontWeight: current ? FontWeight.w700 : FontWeight.w500,
            color: active ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
