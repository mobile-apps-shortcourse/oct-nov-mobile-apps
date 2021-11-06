part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

/// none
class AuthenticationInitial extends AuthenticationState {}

/// loading
class AuthenticationLoading extends AuthenticationState {}

/// success
class AuthenticationSuccess extends AuthenticationState {
  final String username;

  AuthenticationSuccess({required this.username});
}

/// failed / cancelled
class AuthenticationError extends AuthenticationState {
  final String reason;

  AuthenticationError({required this.reason});
}
