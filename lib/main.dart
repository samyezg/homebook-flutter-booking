import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/app/config/app_environment.dart';
import 'package:homebook_app/app/config/app_environment_provider.dart';
import 'package:homebook_app/app/homebook_app.dart';
import 'package:homebook_app/features/bookings/data/mock_bookings_repository.dart';
import 'package:homebook_app/features/bookings/data/supabase_bookings_sync.dart';
import 'package:homebook_app/features/bookings/data/syncing_bookings_repository.dart';
import 'package:homebook_app/features/bookings/domain/bookings_repository.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/reviews/data/mock_reviews_repository.dart';
import 'package:homebook_app/features/reviews/data/supabase_reviews_sync.dart';
import 'package:homebook_app/features/reviews/data/syncing_reviews_repository.dart';
import 'package:homebook_app/features/reviews/domain/reviews_repository.dart';
import 'package:homebook_app/features/reviews/presentation/reviews_notifier.dart';
import 'package:homebook_app/features/settings/presentation/locale_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final env = AppEnvironment.fromDefines();
  if (env.useSupabase) {
    await Supabase.initialize(
      url: env.supabaseUrl!,
      publishableKey: env.supabaseAnonKey!,
    );
  }

  final localBookings = MockBookingsRepository();
  final localReviews = MockReviewsRepository();

  final BookingsRepository bookings = env.useSupabase
      ? SyncingBookingsRepository(
          local: localBookings,
          sync: SupabaseBookingsSync(Supabase.instance.client),
        )
      : localBookings;

  final ReviewsRepository reviews = env.useSupabase
      ? SyncingReviewsRepository(
          local: localReviews,
          sync: SupabaseReviewsSync(Supabase.instance.client),
        )
      : localReviews;

  runApp(
    ProviderScope(
      overrides: [
        appEnvironmentProvider.overrideWithValue(env),
        sharedPreferencesProvider.overrideWithValue(prefs),
        bookingsRepositoryProvider.overrideWithValue(bookings),
        reviewsRepositoryProvider.overrideWithValue(reviews),
      ],
      child: HomeBookApp(),
    ),
  );
}
