import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/app/homebook_app.dart';
import 'package:homebook_app/features/bookings/domain/booking_status.dart';
import 'package:homebook_app/features/services/domain/service_category.dart';
import 'package:homebook_app/features/settings/data/locale_settings_store.dart';
import 'package:homebook_app/features/settings/presentation/locale_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpApp(
    WidgetTester tester, {
    String localePreference = 'zh',
  }) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({
      LocaleSettingsStore.prefsKey: localePreference,
    });
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: HomeBookApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('lists mock services and filters by category', (tester) async {
    await pumpApp(tester);

    expect(find.text('HomeBook'), findsWidgets);
    expect(find.text('Deep Cleaning'), findsOneWidget);
    expect(find.text('Plumbing Repair'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('cat-repair')));
    await tester.pumpAndSettle();

    expect(find.text('Plumbing Repair'), findsOneWidget);
    expect(find.text('Electrical Repair'), findsOneWidget);
    expect(find.text('Deep Cleaning'), findsNothing);
  });

  testWidgets('opens service detail with provider card', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('service-card-svc-deep-clean')));
    await tester.pumpAndSettle();

    expect(find.text('Deep Cleaning'), findsWidgets);
    expect(find.textContaining('到付'), findsWidgets);
    expect(find.byKey(const ValueKey('provider-prov-zhang')), findsOneWidget);
    expect(find.byKey(const ValueKey('book-now')), findsOneWidget);
  });

  testWidgets('booking page shows calendar and confirm CTA', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('service-card-svc-deep-clean')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('book-now')));
    await tester.pumpAndSettle();

    expect(find.text('预约下单'), findsOneWidget);
    expect(find.byKey(const ValueKey('booking-calendar')), findsOneWidget);
    expect(find.byKey(const ValueKey('booking-address')), findsOneWidget);
    expect(find.byKey(const ValueKey('confirm-booking')), findsOneWidget);
  });

  testWidgets('orders tab filters seed and can cancel pending', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('nav-bookings')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('booking-bk-seed-pending')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('booking-filter-pending')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('booking-bk-seed-pending')), findsOneWidget);
    expect(find.byKey(const ValueKey('booking-bk-seed-done')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('booking-bk-seed-pending')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('timeline-pipeline')), findsOneWidget);
    expect(find.byKey(const ValueKey('cancel-booking')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('cancel-booking')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-cancel-booking')));
    await tester.pumpAndSettle();

    expect(find.text('已取消'), findsWidgets);
  });

  testWidgets('provider role can accept pending job', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('nav-profile')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('服务者'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('open-provider-home')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('accept-bk-seed-pending')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('accept-bk-seed-pending')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('accept-bk-seed-pending')), findsNothing);
    expect(find.byKey(const ValueKey('start-bk-seed-pending')), findsOneWidget);
  });

  testWidgets('profile can fake sign up', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('nav-profile')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('open-sign-in')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('go-sign-up')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('sign-up-email')),
      'demo@homebook.test',
    );
    await tester.enterText(
      find.byKey(const ValueKey('sign-up-password')),
      'secret1',
    );
    await tester.tap(find.byKey(const ValueKey('sign-up-submit')));
    await tester.pumpAndSettle();

    expect(find.text('demo@homebook.test'), findsOneWidget);
  });

  testWidgets('completed order can open review form', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const ValueKey('nav-bookings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('booking-filter-completed')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('booking-bk-seed-done')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('open-review')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('open-review')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('submit-review')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('submit-review')));
    await tester.pumpAndSettle();
    expect(find.textContaining('我的评价'), findsOneWidget);
  });

  test('domain enums cover MVP categories and statuses', () {
    expect(ServiceCategory.values.length, 4);
    expect(BookingStatus.values.length, 5);
    expect(BookingStatus.byId('in_progress'), BookingStatus.inProgress);
  });
}
