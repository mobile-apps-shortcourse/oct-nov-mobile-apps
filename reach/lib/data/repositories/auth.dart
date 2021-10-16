import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reach/config/constants.dart';
import 'package:twitter_login/twitter_login.dart';

/// authentication state
enum AuthStatus { unauthenticated, authenticated, unknown, authenticating }

/// base authentication repository.
/// defines the logic for handling authentication
abstract class BaseAuthRepository {
  Stream<AuthStatus> get authState;

  Future googleAuth();

  Future twitterAuth();

  Future<void> signOut();

  void dispose();
}

/// implementation of [BaseAuthRepository]
class AuthRepository extends BaseAuthRepository {
  final GoogleSignIn googleLoginProvider;
  final TwitterLogin twitterLoginProvider;
  final FirebaseAuth auth;

  AuthRepository({
    required this.googleLoginProvider,
    required this.twitterLoginProvider,
    required this.auth,
  });

  /// handles stream events of authentication state
  final StreamController<AuthStatus> _authController =
      StreamController.broadcast()..add(AuthStatus.unknown);

  @override
  Stream<AuthStatus> get authState => _authController.stream;

  @override
  Future googleAuth() async {
    _authController.add(AuthStatus.authenticating);
    try {
      var account = await googleLoginProvider.signIn();
      if (account == null) {
        _authController.add(AuthStatus.unauthenticated);
      } else {
        var authentication = await account.authentication;
        var idToken = authentication.idToken;
        var accessToken = authentication.accessToken;
        var credential = await auth.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: accessToken, idToken: idToken));
        var profile = credential.additionalUserInfo?.profile;
        logger.i('user profile -> $profile');
        _authController.add(AuthStatus.authenticated);
      }
    } catch (e) {
      logger.e(e);
      _authController.add(AuthStatus.unauthenticated);
    }
  }

  @override
  Future<void> signOut() async {
    // sign out
    await googleLoginProvider.signOut();
    // disconnect service
    await googleLoginProvider.disconnect();
  }

  @override
  Future twitterAuth() async {
    _authController.add(AuthStatus.authenticating);
    try {
      var authResult = await twitterLoginProvider.login();
      if (authResult.status == TwitterLoginStatus.loggedIn) {
        var user = authResult.user;
        logger.i('twitter user -> ${user?.id}');
        var credential = await auth.signInWithCredential(
          TwitterAuthProvider.credential(
              accessToken: authResult.authToken!,
              secret: authResult.authTokenSecret!),
        );
        var profile = credential.additionalUserInfo?.profile;
        logger.i('user profile -> $profile');
        _authController.add(AuthStatus.authenticated);
      } else {
        logger.e(authResult.errorMessage);
        _authController.add(AuthStatus.unauthenticated);
      }
    } catch (e) {
      logger.e(e);
      _authController.add(AuthStatus.unauthenticated);
    }
  }

  @override
  void dispose() async {
    await _authController.close();
  }
}
