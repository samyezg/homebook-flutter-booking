import 'package:homebook_app/l10n/app_localizations.dart';

enum AuthEmailIssue { empty, invalid }

enum AuthPasswordIssue { empty, tooShort }

abstract final class AuthValidators {
  static final RegExp _emailPattern = RegExp(
    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  );

  static AuthEmailIssue? emailIssue(String value) {
    final email = value.trim();
    if (email.isEmpty) return AuthEmailIssue.empty;
    if (!_emailPattern.hasMatch(email)) return AuthEmailIssue.invalid;
    return null;
  }

  static AuthPasswordIssue? passwordIssue(String value, {int minLength = 6}) {
    if (value.isEmpty) return AuthPasswordIssue.empty;
    if (value.length < minLength) return AuthPasswordIssue.tooShort;
    return null;
  }

  /// Localized helpers for UI forms.
  static String? emailError(String value, AppLocalizations l10n) {
    return switch (emailIssue(value)) {
      AuthEmailIssue.empty => l10n.authEmailRequired,
      AuthEmailIssue.invalid => l10n.authEmailInvalid,
      null => null,
    };
  }

  static String? passwordError(
    String value,
    AppLocalizations l10n, {
    int minLength = 6,
  }) {
    return switch (passwordIssue(value, minLength: minLength)) {
      AuthPasswordIssue.empty => l10n.authPasswordRequired,
      AuthPasswordIssue.tooShort => l10n.authPasswordTooShort(minLength),
      null => null,
    };
  }

  /// English messages for repository guards (error.message passthrough).
  static String? emailErrorEn(String value) {
    return switch (emailIssue(value)) {
      AuthEmailIssue.empty => 'Enter your email.',
      AuthEmailIssue.invalid => 'Enter a valid email address.',
      null => null,
    };
  }

  static String? passwordErrorEn(String value, {int minLength = 6}) {
    return switch (passwordIssue(value, minLength: minLength)) {
      AuthPasswordIssue.empty => 'Enter your password.',
      AuthPasswordIssue.tooShort =>
        'Password must be at least $minLength characters.',
      null => null,
    };
  }
}
