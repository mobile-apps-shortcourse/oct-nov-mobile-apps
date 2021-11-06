import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reach/config/injector.dart';
import 'package:reach/model/user.dart';
import 'package:reach/repository/persistent.storage.repository.dart';
import 'package:reach/repository/user.repository.dart';
import 'package:twitter_login/twitter_login.dart';

/// sign in providers
enum SignInProvider { google, twitter }

/// authentication state
enum AuthState { none, loading, success, failed, cancelled }

/// authentication business logic
abstract class BaseAuthRepository {
  /// check whether user is logged in
  bool get userIsLoggedIn => false;

  /// observe each state in the authentication process
  Stream<AuthState> get observeAuthState => Stream.value(AuthState.none);

  /// helps to sign in with a selected provider
  Future<void> signInWithProvider({required SignInProvider provider});

  /// sign out a user
  Future<void> signOut();
}

/// implementation of [BaseAuthRepository] using Firebase
class FirebaseAuthRepository extends ChangeNotifier
    implements BaseAuthRepository {
  /// user repo
  final BaseUserRepository userRepo;

  // storage repo
  final PersistentStorageRepository storageRepo;

  /// firebase authentication instance
  final _auth = dependencyProvider.read(firebaseAuthProvider);

  /// google auth instance
  final _googleSignIn = GoogleSignIn();

  /// constructor
  FirebaseAuthRepository({
    required this.userRepo,
    required this.storageRepo,
  });

  /// controller for the authentication state events
  final _authStateController = StreamController<AuthState>.broadcast();

  /// check whether user is logged in
  @override
  bool get userIsLoggedIn => storageRepo.isLoggedIn;

  @override
  Stream<AuthState> get observeAuthState => _authStateController.stream;

  @override
  Future<void> signInWithProvider({required SignInProvider provider}) async {
    /// invoke the loading state
    _authStateController.add(AuthState.loading);

    if (provider == SignInProvider.google) {
      try {
        /// invoke google sign in
        var account = await _googleSignIn.signIn();

        if (account == null) {
          /// failed
          _authStateController.add(AuthState.failed);
        } else {
          /// success

          /// obtain the authentication details of the logged in user
          var authentication = await account.authentication;

          /// create a sign in provider for firebase using google
          var googleCredential = GoogleAuthProvider.credential(
            idToken: authentication.idToken,
            accessToken: authentication.accessToken,
          );

          /// firebase authentication
          var userCredential =
              await _auth.signInWithCredential(googleCredential);
          var username = userCredential.user?.displayName;
          var email = userCredential.user?.email;
          var uid = userCredential.user?.uid;

          /// create a new user object
          var today =
              DateTime.now().millisecondsSinceEpoch; // e.g. 1509230920290323
          var userAccount = UserAccount(
            id: uid!,
            username: username!,
            email: email!,
            lastLoginDate: today,
            createdOn: today,
            avatar: userCredential.user?.photoURL,
          );

          /// store user data in the cloud firestore
          /// users/1234
          await userRepo.updateUser(account: userAccount);
          await storageRepo.saveUserId(userAccount.id);
          _authStateController.add(AuthState.success);
        }
      } on PlatformException catch (e) {
        print('authentication failed -> ${e.message}');
        _authStateController.add(AuthState.cancelled);
      }
    } else {
      /// do twitter authentication
      try {
        final twitterLogin = TwitterLogin(
          // Consumer API keys
          apiKey: 'aMSQJ2pKHYVborAGo0w72Y2CY',
          // Consumer API Secret keys
          apiSecretKey: '5NjxvhwsSCqHxCWOKCr7j833rwR6oyOGeANVYzyYhg16GBC3LX',
          // Registered Callback URLs in TwitterApp
          // Android is a deeplink
          // iOS is a URLScheme
          redirectURI: 'https://reach-twitter-auth',
        );
        final authResult = await twitterLogin.login();
        switch (authResult.status) {
          case TwitterLoginStatus.loggedIn:

            /// get credentials
            var twitterCredential = TwitterAuthProvider.credential(
              accessToken: authResult.authToken!,
              secret: authResult.authTokenSecret!,
            );

            /// firebase authentication
            var userCredential =
                await _auth.signInWithCredential(twitterCredential);
            var username = userCredential.user?.displayName;
            var email = userCredential.user?.email;
            var uid = userCredential.user?.uid;

            /// create a new user object
            var today =
                DateTime.now().millisecondsSinceEpoch; // e.g. 1509230920290323
            var userAccount = UserAccount(
              id: uid!,
              username: username!,
              email: email!,
              lastLoginDate: today,
              createdOn: today,
              avatar: userCredential.user?.photoURL,
            );

            /// store user data in the cloud firestore
            /// users/1234
            await userRepo.updateUser(account: userAccount);
            await storageRepo.saveUserId(userAccount.id);
            _authStateController.add(AuthState.success);
            break;
          case TwitterLoginStatus.cancelledByUser:

            /// cancel
            _authStateController.add(AuthState.cancelled);
            break;
          case TwitterLoginStatus.error:

            /// error
            _authStateController.add(AuthState.failed);
            break;

          default:

            /// if no cases above are met, then do something else
            _authStateController.add(AuthState.cancelled);
            break;
        }
      } on PlatformException catch (e) {
        print('authentication failed -> ${e.message}');
        _authStateController.add(AuthState.cancelled);
      }
    }
  }

  @override
  Future<void> signOut() async {
    /// check if user signed in with google account
    var googleUser = _googleSignIn.currentUser;
    if (googleUser != null) {
      /// user exists, sign out that user
      await _googleSignIn.signOut();
    }

    /// firebase auth sign out
    await _auth.signOut();

    await storageRepo.clear();

    _authStateController.add(AuthState.none);
  }
}
