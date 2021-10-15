import 'package:google_sign_in/google_sign_in.dart';
import 'package:reach/data/repositories/auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twitter_login/twitter_login.dart';

/// container for providing instances of dependencies
final _container = ProviderContainer();

/// provides a singleton of [GoogleSignIn]
final _googleLoginProvider = Provider((_) => GoogleSignIn());

/// provides a singleton of [TwitterLogin]
final _twitterLoginProvider = Provider((_) => TwitterLogin(
    apiKey: 'apiKey',
    apiSecretKey: 'apiSecretKey',
    redirectURI: 'redirectURI'));

/// [BaseAuthRepository] instance
BaseAuthRepository authRepository = AuthRepository(
  googleLoginProvider: _container.read(_googleLoginProvider),
  twitterLoginProvider: _container.read(_twitterLoginProvider),
);
