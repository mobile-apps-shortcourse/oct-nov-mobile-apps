import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reach/repository/auth.repository.dart';

import 'auth.mocks.dart';

// flutter packages pub run build_runner build

@GenerateMocks([BaseAuthRepository])
void main() async {
  /// fake implementation of the [BaseAuthRepository]
  final repository = MockBaseAuthRepository();

  test('social login', () async {
    /// give conditions
    when(repository.signInWithProvider(provider: anyNamed('provider')))
        .thenAnswer((realInvocation) => Future<void>.value());
    when(repository.observeAuthState)
        .thenAnswer((realInvocation) => Stream.fromIterable([
              AuthState.none,
              AuthState.loading,
              AuthState.success,
            ]));

    /// assert these conditions
    await repository.signInWithProvider(provider: SignInProvider.google);
    expectLater(
        repository.observeAuthState,
        emitsInOrder([
          AuthState.none,
          AuthState.loading,
          AuthState.success,
        ]));
  });
}
