import 'package:flutter/material.dart';
import 'package:homebook_app/app/theme/app_colors.dart';

enum BookingStatus {
  pending(id: 'pending'),
  accepted(id: 'accepted'),
  inProgress(id: 'in_progress'),
  completed(id: 'completed'),
  cancelled(id: 'cancelled');

  const BookingStatus({required this.id});

  final String id;

  Color get color => switch (this) {
        BookingStatus.pending => AppColors.statusPending,
        BookingStatus.accepted => AppColors.statusAccepted,
        BookingStatus.inProgress => AppColors.statusInProgress,
        BookingStatus.completed => AppColors.statusCompleted,
        BookingStatus.cancelled => AppColors.statusCancelled,
      };

  bool get canCancel =>
      this == BookingStatus.pending || this == BookingStatus.accepted;

  /// Happy-path pipeline for timeline UI (excludes cancelled).
  static const pipeline = <BookingStatus>[
    BookingStatus.pending,
    BookingStatus.accepted,
    BookingStatus.inProgress,
    BookingStatus.completed,
  ];

  static BookingStatus byId(String id) {
    for (final item in values) {
      if (item.id == id) return item;
    }
    return BookingStatus.pending;
  }
}
