import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reach/data/repositories/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BaseAuthRepository repository;

  AuthCubit({required this.repository}) : super(AuthInitial()) {
    /// listen to the authentication status once the class is created
    repository.authState.listen((state) {
      if (state == AuthStatus.authenticated) {
        emit(AuthSuccess());
      } else if (state == AuthStatus.unauthenticated) {
        emit(AuthError('Failed to sign in'));
      } else if (state == AuthStatus.authenticating) {
        emit(AuthLoading());
      } else {
        emit(AuthInitial());
      }
    });
  }

  Future<void> googleSignIn() async => await repository.googleAuth();

  Future<void> twitterSignIn() async => await repository.twitterAuth();

  Future<void> signOut() async => await repository.signOut();

  @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
