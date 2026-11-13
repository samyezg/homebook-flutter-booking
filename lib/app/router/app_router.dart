import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/router/app_shell.dart';
import 'package:homebook_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:homebook_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:homebook_app/features/bookings/presentation/pages/booking_detail_page.dart';
import 'package:homebook_app/features/bookings/presentation/pages/booking_list_page.dart';
import 'package:homebook_app/features/bookings/presentation/pages/booking_page.dart';
import 'package:homebook_app/features/profile/presentation/pages/profile_page.dart';
import 'package:homebook_app/features/providers/presentation/pages/provider_home_page.dart';
import 'package:homebook_app/features/reviews/presentation/pages/review_page.dart';
import 'package:homebook_app/features/services/presentation/pages/service_detail_page.dart';
import 'package:homebook_app/features/services/presentation/pages/service_list_page.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const ServiceListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.bookings,
                builder: (context, state) => const BookingListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.serviceDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ServiceDetailPage(serviceId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.book,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return BookingPage(serviceId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.bookingReview,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ReviewPage(bookingId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.bookingDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return BookingDetailPage(bookingId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.providerHome,
        builder: (context, state) => const ProviderHomePage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
    ],
  );
}
