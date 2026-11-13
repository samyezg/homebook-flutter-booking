import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_router.dart';
import 'package:homebook_app/app/theme/app_theme.dart';
import 'package:homebook_app/features/settings/presentation/locale_notifier.dart';
import 'package:homebook_app/l10n/app_localizations.dart';

class HomeBookApp extends ConsumerStatefulWidget {
  HomeBookApp({super.key, GoRouter? router})
      : router = router ?? createAppRouter();

  final GoRouter router;

  @override
  ConsumerState<HomeBookApp> createState() => _HomeBookAppState();
}

class _HomeBookAppState extends ConsumerState<HomeBookApp> {
  static const _supported = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  @override
  Widget build(BuildContext context) {
    final localePreference = ref.watch(localePreferenceProvider);
    final materialLocale = localePreference.trim().isEmpty
        ? null
        : Locale(localePreference.trim());

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: widget.router,
      locale: materialLocale,
      supportedLocales: _supported,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback: (locale, supported) {
        if (locale == null) return const Locale('en');
        for (final item in supported) {
          if (item.languageCode == locale.languageCode) return item;
        }
        if (locale.languageCode.toLowerCase().startsWith('zh')) {
          return const Locale('zh');
        }
        return const Locale('en');
      },
    );
  }
}
