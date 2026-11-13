import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/auth/domain/auth_validators.dart';

void main() {
  test('emailIssue covers empty and invalid', () {
    expect(AuthValidators.emailIssue(''), AuthEmailIssue.empty);
    expect(AuthValidators.emailIssue('not-an-email'), AuthEmailIssue.invalid);
    expect(AuthValidators.emailIssue('demo@homebook.test'), isNull);
  });

  test('passwordIssue covers empty and too short', () {
    expect(AuthValidators.passwordIssue(''), AuthPasswordIssue.empty);
    expect(AuthValidators.passwordIssue('12345'), AuthPasswordIssue.tooShort);
    expect(AuthValidators.passwordIssue('secret1'), isNull);
  });

  test('English repository guards match issue enum', () {
    expect(AuthValidators.emailErrorEn(''), 'Enter your email.');
    expect(
      AuthValidators.emailErrorEn('bad'),
      'Enter a valid email address.',
    );
    expect(AuthValidators.passwordErrorEn(''), 'Enter your password.');
    expect(
      AuthValidators.passwordErrorEn('123'),
      'Password must be at least 6 characters.',
    );
    expect(AuthValidators.emailErrorEn('a@b.com'), isNull);
    expect(AuthValidators.passwordErrorEn('secret1'), isNull);
  });
}
