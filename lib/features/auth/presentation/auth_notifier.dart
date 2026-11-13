import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/app/config/app_environment_provider.dart';
import 'package:homebook_app/features/auth/data/fake_auth_repository.dart';
import 'package:homebook_app/features/auth/data/supabase_auth_repository.dart';
import 'package:homebook_app/features/auth/domain/auth_repository.dart';
import 'package:homebook_app/features/auth/domain/auth_user.dart';
import 'package:homebook_app/features/bookings/data/syncing_bookings_repository.dart';
import 'package:homebook_app/features/bookings/presentation/bookings_notifier.dart';
import 'package:homebook_app/features/reviews/data/syncing_reviews_repository.dart';
import 'package:homebook_app/features/reviews/presentation/reviews_notifier.dart';
import 'package:homebook_app/features/session/active_user_id.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final env = ref.watch(appEnvironmentProvider);
  if (env.useSupabase) {
    return SupabaseAuthRepository(Supabase.instance.client);
  }
  return FakeAuthRepository();
});

class AuthNotifier extends Notifier<AuthUser?> {
  @override
  AuthUser? build() {
    return ref.read(authRepositoryProvider).currentUser;
  }

  Future<void> _syncAfterAuth() async {
    final bookings = ref.read(bookingsRepositoryProvider);
    if (bookings is SyncingBookingsRepository) {
      await bookings.pullAndMerge();
      ref.invalidate(bookingsProvider);
    }
    final reviews = ref.read(reviewsRepositoryProvider);
    if (reviews is SyncingReviewsRepository) {
      await reviews.pullAndMerge();
      ref.invalidate(reviewsProvider);
    }
  }

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final user = await ref.read(authRepositoryProvider).signIn(
          email: email,
          password: password,
        );
    state = user;
    ref.read(activeUserIdProvider.notifier).setId(user.id);
    await _syncAfterAuth();
    return user;
  }

  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    final user = await ref.read(authRepositoryProvider).signUp(
          email: email,
          password: password,
        );
    state = user;
    ref.read(activeUserIdProvider.notifier).setId(user.id);
    await _syncAfterAuth();
    return user;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = null;
    ref.read(activeUserIdProvider.notifier).clear();
  }

  Future<void> syncFromCloud() => _syncAfterAuth();
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthUser?>(AuthNotifier.new);

final isSignedInProvider = Provider<bool>((ref) {
  return ref.watch(authProvider) != null;
});
