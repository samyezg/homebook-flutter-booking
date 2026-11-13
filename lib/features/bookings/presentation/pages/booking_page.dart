import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/core/widgets/calendar_picker.dart';
import 'package:homebook_app/features/bookings/domain/booking_time_slots.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/services/presentation/services_providers.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';
import 'package:intl/intl.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key, required this.serviceId});

  final String serviceId;

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  int? _selectedHour;
  late final TextEditingController _addressController;
  late final TextEditingController _notesController;
  var _submitting = false;
  var _addressSeeded = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, now.day);
    _selectedDay = _focusedDay;
    _addressController = TextEditingController();
    _notesController = TextEditingController();
    _selectedHour = BookingTimeSlots.firstSelectableHour(_selectedDay);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_addressSeeded) {
      _addressSeeded = true;
      _addressController.text = context.l10n.defaultAddressHint;
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final service = ref.read(serviceByIdProvider(widget.serviceId));
    if (service == null) return;
    if (_selectedHour == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectTimeSlot)),
      );
      return;
    }
    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.enterAddress)),
      );
      return;
    }
    if (!BookingTimeSlots.isSlotSelectable(_selectedDay, _selectedHour!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.slotUnavailable)),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      final booking = ref.read(bookingsProvider.notifier).create(
            providerId: service.providerId,
            serviceId: service.id,
            serviceName: service.name,
            scheduledAt:
                BookingTimeSlots.combine(_selectedDay, _selectedHour!),
            address: _addressController.text,
            totalCents: service.priceCents,
            notes: _notesController.text,
          );
      if (!mounted) return;
      context.go(AppRoutes.bookingDetailLocation(booking.id));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = ref.watch(serviceByIdProvider(widget.serviceId));

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.bookTitle)),
        body: Center(child: Text(l10n.serviceMissing)),
      );
    }

    final dateLabel = DateFormat('yyyy-MM-dd').format(_selectedDay);
    final slotLabel = _selectedHour == null
        ? l10n.slotNotSelected
        : BookingTimeSlots.label(_selectedHour!);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.bookTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            service.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.durationPricePayOnSite(
              l10n.serviceDurationLabel(service),
              service.priceLabel,
            ),
            style: const TextStyle(
              fontFamily: AppFonts.secondary,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.selectDate,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: CalendarPicker(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = DateTime(
                      selected.year,
                      selected.month,
                      selected.day,
                    );
                    _focusedDay = focused;
                    if (_selectedHour != null &&
                        !BookingTimeSlots.isSlotSelectable(
                          _selectedDay,
                          _selectedHour!,
                        )) {
                      _selectedHour = null;
                    }
                    _selectedHour ??=
                        BookingTimeSlots.firstSelectableHour(_selectedDay);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.selectTime(dateLabel),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final hour in BookingTimeSlots.hours)
                ChoiceChip(
                  key: ValueKey('slot-$hour'),
                  label: Text(BookingTimeSlots.label(hour)),
                  selected: _selectedHour == hour,
                  onSelected:
                      BookingTimeSlots.isSlotSelectable(_selectedDay, hour)
                          ? (_) => setState(() => _selectedHour = hour)
                          : null,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.visitAddress,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            key: const ValueKey('booking-address'),
            controller: _addressController,
            decoration: InputDecoration(hintText: l10n.addressHint),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.notesOptional,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            key: const ValueKey('booking-notes'),
            controller: _notesController,
            decoration: InputDecoration(hintText: l10n.notesHint),
            maxLines: 3,
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Text(
              l10n.bookingSummary(service.priceLabel, slotLabel),
              style: const TextStyle(
                fontFamily: AppFonts.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: FilledButton(
            key: const ValueKey('confirm-booking'),
            onPressed: _submitting ? null : _submit,
            child: Text(
              _submitting
                  ? l10n.submitting
                  : l10n.confirmBooking(service.priceLabel),
            ),
          ),
        ),
      ),
    );
  }
}
