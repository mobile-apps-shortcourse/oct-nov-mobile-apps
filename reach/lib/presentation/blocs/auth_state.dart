part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

/// loading state
class AuthLoading extends AuthState {}

/// error state
class AuthError extends AuthState {
  final String reason;

  AuthError(this.reason);
}

/// success state
class AuthSuccess extends AuthState {
  AuthSuccess();
}
