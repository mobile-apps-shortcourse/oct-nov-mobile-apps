import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reach/data/entities/user.dart';
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

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    if (repository.isLoggedIn) {
      emit(AuthSuccess());
    } else {
      emit(AuthError('User not logged in'));
    }
  }

  bool get isAudience => repository.userType == UserType.audience;

  bool get isInfluencer => repository.userType == UserType.influencer;

  bool get isBrand => repository.userType == UserType.brand;

  bool get hasUnknownUserType => repository.userType == UserType.none;

  Future<void> googleSignIn() async => await repository.googleAuth();

  Future<void> twitterSignIn() async => await repository.twitterAuth();

  Future<void> signOut() async => await repository.signOut();

  @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }

  Future<void> saveUserType(UserType userType) async {
    emit(AuthLoading());
    await repository.updateUserType(userType);
    emit(AuthSuccess());
  }
}
