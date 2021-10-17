import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/data/entities/user.dart';
import 'package:reach/data/repositories/persistent.storage.dart';
import 'package:twitter_login/twitter_login.dart';

/// authentication state
enum AuthStatus { unauthenticated, authenticated, unknown, authenticating }

/// base authentication repository.
/// defines the logic for handling authentication
abstract class BaseAuthRepository {
  Stream<AuthStatus> get authState;

  bool get isLoggedIn;

  UserType get userType;

  Future googleAuth();

  Future twitterAuth();

  Future<void> signOut();

  void dispose();

  Future<void> updateUserType(UserType userType);
}

/// implementation of [BaseAuthRepository]
class AuthRepository extends BaseAuthRepository {
  final GoogleSignIn googleLoginProvider;
  final TwitterLogin twitterLoginProvider;
  final FirebaseAuth auth;
  final BasePersistentStorage storage;

  AuthRepository({
    required this.googleLoginProvider,
    required this.twitterLoginProvider,
    required this.auth,
    required this.storage,
  });

  /// handles stream events of authentication state
  final StreamController<AuthStatus> _authController =
      StreamController.broadcast()..add(AuthStatus.unknown);

  @override
  Stream<AuthStatus> get authState => _authController.stream;

  @override
  bool get isLoggedIn => storage.isLoggedIn;

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
        if (credential.user != null) storage.saveUserId(credential.user!.uid);
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
    // clear storage
    await storage.clear();
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
        if (credential.user != null) storage.saveUserId(credential.user!.uid);
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

  @override
  Future<void> updateUserType(UserType userType) async =>
      await storage.saveUserType(userType);

  @override
  UserType get userType => storage.userType;
}
