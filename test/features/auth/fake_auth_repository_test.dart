import 'package:flutter_test/flutter_test.dart';
import 'package:homebook_app/features/auth/data/fake_auth_repository.dart';
import 'package:homebook_app/features/auth/domain/auth_exception.dart';

void main() {
  test('fake auth signs up then signs in', () async {
    final repo = FakeAuthRepository();
    final created = await repo.signUp(
      email: 'demo@homebook.test',
      password: 'secret1',
    );
    expect(created.email, 'demo@homebook.test');
    expect(repo.currentUser, isNotNull);

    await repo.signOut();
    expect(repo.currentUser, isNull);

    final signedIn = await repo.signIn(
      email: 'demo@homebook.test',
      password: 'secret1',
    );
    expect(signedIn.id, startsWith('fake-'));
  });

  test('fake auth rejects bad password', () async {
    final repo = FakeAuthRepository();
    await repo.signUp(email: 'a@b.com', password: 'secret1');
    await repo.signOut();
    expect(
      () => repo.signIn(email: 'a@b.com', password: 'wrong!!'),
      throwsA(isA<AuthException>()),
    );
  });
}
