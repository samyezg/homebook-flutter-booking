import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/booking_status_chip.dart';
import 'package:homebook_app/features/bookings/domain/booking.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/profile/domain/app_role.dart';
import 'package:homebook_app/features/profile/presentation/role_notifier.dart';
import 'package:homebook_app/features/services/presentation/services_providers.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';
import 'package:intl/intl.dart';

class ProviderHomePage extends ConsumerWidget {
  const ProviderHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final role = ref.watch(appRoleProvider);
    if (role != AppRole.provider) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.providerHomeTitle)),
        body: Center(
          child: FilledButton(
            onPressed: () {
              ref.read(appRoleProvider.notifier).setRole(AppRole.provider);
            },
            child: Text(l10n.switchToProviderRole),
          ),
        ),
      );
    }

    final providers = ref.watch(providersListProvider);
    final activeId = ref.watch(activeProviderIdProvider);
    final pending = ref.watch(providerPendingBookingsProvider);
    final active = ref.watch(providerActiveBookingsProvider);
    final allForProvider = ref
        .watch(bookingsRepositoryProvider)
        .listForProvider(activeId);
    // Touch bookings so counts refresh.
    ref.watch(bookingsProvider);
    final completedCount = allForProvider
        .where((b) => b.status == BookingStatus.completed)
        .length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.providerHomeTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.providerProfile,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final provider in providers)
                ChoiceChip(
                  key: ValueKey('provider-identity-${provider.id}'),
                  label: Text(provider.name),
                  selected: activeId == provider.id,
                  onSelected: (_) {
                    ref.read(activeProviderIdProvider.notifier).setId(provider.id);
                  },
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.inProgressCompletedCount(active.length, completedCount),
            style: const TextStyle(
              fontFamily: AppFonts.secondary,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.newBookings,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (pending.isEmpty)
            Text(
              l10n.noPendingBookings,
              style: const TextStyle(
                fontFamily: AppFonts.secondary,
                color: AppColors.textSecondary,
              ),
            )
          else
            for (final booking in pending)
              _ProviderBookingCard(
                booking: booking,
                actions: [
                  OutlinedButton(
                    key: ValueKey('reject-${booking.id}'),
                    onPressed: () => _run(
                      context,
                      () => ref.read(bookingsProvider.notifier).reject(booking.id),
                    ),
                    child: Text(l10n.reject),
                  ),
                  FilledButton(
                    key: ValueKey('accept-${booking.id}'),
                    onPressed: () => _run(
                      context,
                      () => ref.read(bookingsProvider.notifier).accept(booking.id),
                    ),
                    child: Text(l10n.accept),
                  ),
                ],
              ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.myActive,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (active.isEmpty)
            Text(
              l10n.noActiveBookings,
              style: const TextStyle(
                fontFamily: AppFonts.secondary,
                color: AppColors.textSecondary,
              ),
            )
          else
            for (final booking in active)
              _ProviderBookingCard(
                booking: booking,
                actions: [
                  if (booking.status == BookingStatus.accepted)
                    FilledButton(
                      key: ValueKey('start-${booking.id}'),
                      onPressed: () => _run(
                        context,
                        () =>
                            ref.read(bookingsProvider.notifier).start(booking.id),
                      ),
                      child: Text(l10n.startService),
                    ),
                  if (booking.status == BookingStatus.inProgress)
                    FilledButton(
                      key: ValueKey('complete-${booking.id}'),
                      onPressed: () => _run(
                        context,
                        () => ref
                            .read(bookingsProvider.notifier)
                            .complete(booking.id),
                      ),
                      child: Text(l10n.complete),
                    ),
                ],
              ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.availableHours,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Wrap(
            spacing: AppSpacing.xs,
            children: [
              Chip(label: Text('09:00')),
              Chip(label: Text('10:00')),
              Chip(label: Text('14:00')),
              Chip(label: Text('15:00')),
              Chip(label: Text('16:00')),
              Chip(label: Text('18:00')),
            ],
          ),
        ],
      ),
    );
  }

  void _run(BuildContext context, Booking Function() action) {
    try {
      action();
    } on BookingException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }
}

class _ProviderBookingCard extends StatelessWidget {
  const _ProviderBookingCard({
    required this.booking,
    required this.actions,
  });

  final Booking booking;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final when = DateFormat('MM-dd HH:mm').format(booking.scheduledAt);
    return Card(
      key: ValueKey('provider-booking-${booking.id}'),
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.serviceName,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                BookingStatusChip(status: booking.status),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$when · ${booking.priceLabel}',
              style: const TextStyle(
                fontFamily: AppFonts.secondary,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              booking.address,
              style: const TextStyle(fontFamily: AppFonts.secondary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                  onPressed: () => context.push(
                    AppRoutes.bookingDetailLocation(booking.id),
                  ),
                  child: Text(context.l10n.details),
                ),
                ...actions,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
