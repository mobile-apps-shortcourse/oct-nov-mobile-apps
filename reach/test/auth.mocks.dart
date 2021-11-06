// Mocks generated by Mockito 5.0.16 from annotations
// in reach/test/auth.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:reach/repository/auth.repository.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [BaseAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseAuthRepository extends _i1.Mock
    implements _i2.BaseAuthRepository {
  MockBaseAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get userIsLoggedIn => (super
          .noSuchMethod(Invocation.getter(#userIsLoggedIn), returnValue: false)
      as bool);
  @override
  _i3.Stream<_i2.AuthState> get observeAuthState => (super.noSuchMethod(
      Invocation.getter(#observeAuthState),
      returnValue: Stream<_i2.AuthState>.empty()) as _i3.Stream<_i2.AuthState>);
  @override
  _i3.Future<void> signInWithProvider({_i2.SignInProvider? provider}) =>
      (super.noSuchMethod(
          Invocation.method(#signInWithProvider, [], {#provider: provider}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}
