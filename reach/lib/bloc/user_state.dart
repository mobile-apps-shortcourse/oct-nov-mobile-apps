part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess<T> extends UserState {
  final T? data;

  UserSuccess({required this.data});
}

class UserError extends UserState {
  final String reason;

  UserError({required this.reason});
}
