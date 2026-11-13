import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/booking_status_chip.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';
import 'package:intl/intl.dart';

class BookingListPage extends ConsumerWidget {
  const BookingListPage({super.key});

  static const _filters = <BookingStatus?>[
    null,
    BookingStatus.pending,
    BookingStatus.accepted,
    BookingStatus.inProgress,
    BookingStatus.completed,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(bookingListFilterProvider);
    final bookings = ref.watch(filteredBookingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myBookings)),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, index) {
                final value = _filters[index];
                final label =
                    value == null ? l10n.filterAll : l10n.bookingStatusLabel(value);
                return FilterChip(
                  key: ValueKey('booking-filter-${value?.id ?? 'all'}'),
                  label: Text(label),
                  selected: filter == value,
                  onSelected: (_) {
                    ref.read(bookingListFilterProvider.notifier).setFilter(value);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: bookings.isEmpty
                ? Center(
                    child: Text(
                      l10n.bookingsEmpty,
                      style: const TextStyle(
                        fontFamily: AppFonts.secondary,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: bookings.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final when = DateFormat('MM-dd HH:mm')
                          .format(booking.scheduledAt);
                      return ListTile(
                        key: ValueKey('booking-${booking.id}'),
                        contentPadding: EdgeInsets.zero,
                        title: Text(booking.serviceName),
                        subtitle: Text(
                          '$when · ${booking.priceLabel}',
                          style: const TextStyle(
                            fontFamily: AppFonts.secondary,
                          ),
                        ),
                        trailing: BookingStatusChip(status: booking.status),
                        onTap: () => context.push(
                          AppRoutes.bookingDetailLocation(booking.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
