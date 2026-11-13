import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebook_app/features/settings/data/locale_settings_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'Override sharedPreferencesProvider in main() / tests.',
  );
});

final localeSettingsStoreProvider = Provider<LocaleSettingsStore>((ref) {
  return LocaleSettingsStore(ref.watch(sharedPreferencesProvider));
});

/// `''` = follow system; `en` / `zh` = locked.
class LocalePreference extends Notifier<String> {
  @override
  String build() {
    return ref.watch(localeSettingsStoreProvider).getPreference();
  }

  Future<void> setPreference(String? preference) async {
    final normalized = (preference ?? '').trim();
    await ref.read(localeSettingsStoreProvider).setPreference(normalized);
    state = normalized;
  }

  Locale? get materialLocale {
    final code = state.trim();
    if (code.isEmpty) return null;
    return Locale(code);
  }
}

final localePreferenceProvider =
    NotifierProvider<LocalePreference, String>(LocalePreference.new);
