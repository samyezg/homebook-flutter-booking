import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/booking_status_chip.dart';
import 'package:homebook_app/core/widgets/booking_status_timeline.dart';
import 'package:homebook_app/core/widgets/provider_card.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/reviews/presentation/reviews_notifier.dart';
import 'package:homebook_app/features/services/presentation/services_providers.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';
import 'package:intl/intl.dart';

class BookingDetailPage extends ConsumerWidget {
  const BookingDetailPage({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final booking = ref.watch(bookingByIdProvider(bookingId));

    if (booking == null) {
      return Scaffold(
        appBar: _appBar(context, l10n.bookingDetailTitle),
        body: Center(child: Text(l10n.bookingMissing)),
      );
    }

    final provider = ref.watch(providerByIdProvider(booking.providerId));
    final review = ref.watch(reviewByBookingIdProvider(bookingId));
    final when = DateFormat('yyyy-MM-dd HH:mm').format(booking.scheduledAt);
    final canReview =
        booking.status == BookingStatus.completed && review == null;

    return Scaffold(
      appBar: _appBar(context, l10n.bookingDetailTitle),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Row(
            children: [
              BookingStatusChip(status: booking.status),
              const Spacer(),
              Text(
                booking.priceLabel,
                style: const TextStyle(
                  fontFamily: AppFonts.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            booking.serviceName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.statusTracking,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          BookingStatusTimeline(status: booking.status),
          const SizedBox(height: AppSpacing.lg),
          if (provider != null) ...[
            Text(
              l10n.provider,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ProviderCard(provider: provider),
            const SizedBox(height: AppSpacing.lg),
          ],
          _row(l10n.labelTime, when),
          _row(l10n.labelAddress, booking.address),
          if (booking.notes.isNotEmpty) _row(l10n.labelNotes, booking.notes),
          _row(l10n.labelPayment, l10n.paymentPayOnSite),
          if (review != null) ...[
            const SizedBox(height: AppSpacing.md),
            _row(
              l10n.labelMyReview,
              '${l10n.reviewStars(review.rating)}${review.comment.isEmpty ? '' : ' · ${review.comment}'}',
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  key: const ValueKey('contact-provider'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.contactUnavailable)),
                    );
                  },
                  child: Text(l10n.contactProvider),
                ),
              ),
              if (canReview) ...[
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: FilledButton(
                    key: const ValueKey('open-review'),
                    onPressed: () => context.push(
                      AppRoutes.bookingReviewLocation(bookingId),
                    ),
                    child: Text(l10n.writeReview),
                  ),
                ),
              ] else if (booking.status.canCancel) ...[
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: FilledButton(
                    key: const ValueKey('cancel-booking'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.statusCancelled,
                    ),
                    onPressed: () => _cancel(context, ref),
                    child: Text(l10n.cancelBooking),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Always show a back control. After Confirm booking the page is opened with
  /// `context.go`, so [Navigator.canPop] is false — fall back to Bookings tab.
  AppBar _appBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
      leading: BackButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.bookings);
          }
        },
      ),
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final dialogL10n = context.l10n;
        return AlertDialog(
          title: Text(dialogL10n.cancelBookingTitle),
          content: Text(dialogL10n.cancelBookingBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(dialogL10n.back),
            ),
            FilledButton(
              key: const ValueKey('confirm-cancel-booking'),
              onPressed: () => Navigator.pop(context, true),
              child: Text(dialogL10n.confirmCancel),
            ),
          ],
        );
      },
    );
    if (confirmed != true) return;

    try {
      ref.read(bookingsProvider.notifier).cancel(bookingId);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bookingCancelledSnack)),
      );
    } on BookingException catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: AppFonts.secondary,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: AppFonts.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
