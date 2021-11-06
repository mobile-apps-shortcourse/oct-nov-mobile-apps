import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reach/repository/auth.repository.dart';

part 'authentication_state.dart';

/// used to communicate events from the auth repository to the UI
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final BaseAuthRepository repository;

  AuthenticationCubit({required this.repository})
      : super(AuthenticationInitial()) {
    repository.observeAuthState.listen((state) {
      /// emit to UI from here
      switch (state) {
        case AuthState.loading:
          emit(AuthenticationLoading());
          break;
        case AuthState.success:
          emit(AuthenticationSuccess(username: 'Hello World'));
          break;
        case AuthState.failed:
        case AuthState.cancelled:
          emit(AuthenticationError(
              reason: state == AuthState.failed
                  ? 'Failed to sign in with provider'
                  : 'User cancelled the process'));
          break;
        case AuthState.none:

          /// do nothing
          break;
      }
    });
  }

  bool get userIsLoggedIn => repository.userIsLoggedIn;

  Future<void> signInWithProvider({required SignInProvider provider}) async =>
      await repository.signInWithProvider(provider: provider);

  Future<void> signOut() async => await repository.signOut();
}
