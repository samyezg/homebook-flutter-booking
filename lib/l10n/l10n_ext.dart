import 'package:flutter/widgets.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/profile/domain/app_role.dart';
import 'package:homebook_app/features/services/domain/service.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';
import 'package:homebook_app/l10n/app_localizations.dart';

export 'package:homebook_app/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension HomeBookLocalizations on AppLocalizations {
  String serviceCategoryLabel(ServiceCategory category) => switch (category) {
        ServiceCategory.cleaning => categoryCleaning,
        ServiceCategory.repair => categoryRepair,
        ServiceCategory.renovation => categoryRenovation,
        ServiceCategory.moving => categoryMoving,
      };

  String bookingStatusLabel(BookingStatus status) => switch (status) {
        BookingStatus.pending => statusPending,
        BookingStatus.accepted => statusAccepted,
        BookingStatus.inProgress => statusInProgress,
        BookingStatus.completed => statusCompleted,
        BookingStatus.cancelled => statusCancelled,
      };

  String appRoleLabel(AppRole role) => switch (role) {
        AppRole.user => roleUser,
        AppRole.provider => roleProvider,
      };

  String serviceDurationLabel(Service service) {
    final minutes = service.durationMinutes;
    if (minutes >= 24 * 60 && minutes % (24 * 60) == 0) {
      return durationDays(minutes ~/ (24 * 60));
    }
    if (minutes % 60 == 0) {
      return durationHours(minutes ~/ 60);
    }
    return durationMinutesLabel(minutes);
  }
}
