import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reach/data/repositories/auth.dart';
import 'package:reach/data/repositories/persistent.storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

/// container for providing instances of dependencies
final _container = ProviderContainer();

/// provides a singleton of [SharedPreferences]
final _prefsProvider =
    FutureProvider((_) async => await SharedPreferences.getInstance());

/// provides a singleton of [BasePersistentStorage]
final _persistentStorageProvider =
    Provider.family<BasePersistentStorage, SharedPreferences>(
        (_, prefs) => PersistentStorage(prefs: prefs));

/// provides a singleton of [GoogleSignIn]
final _googleLoginProvider = Provider((_) => GoogleSignIn());

/// provides a singleton of [TwitterLogin]
final _twitterLoginProvider = Provider(
  (_) => TwitterLogin(
    apiKey: 'hUSdkddl6GDhaEjVzNbOqq7IX',
    apiSecretKey: 'dUI4kveC7UUXbTuREn8x8QRwgy7vm9odSBcebvLZmdRS2ZpaCO',
    redirectURI: 'https://twitter-firebase-auth',
  ),
);

/// provides a singleton of [FirebaseAuth]
final _authProvider = Provider((_) => FirebaseAuth.instance);

/// [BaseAuthRepository] instance
class Injector {
  static final _deps = [];

  static Future<void> inject() async {
    /// initialize firebase
    await Firebase.initializeApp();

    var prefs = await _container.read(_prefsProvider.future);
    var _persistentStorage = _container.read(_persistentStorageProvider(prefs));

    /// authentication
    BaseAuthRepository authRepository = AuthRepository(
      googleLoginProvider: _container.read(_googleLoginProvider),
      twitterLoginProvider: _container.read(_twitterLoginProvider),
      auth: _container.read(_authProvider),
      storage: _persistentStorage,
    );

    /// add to dependencies
    _deps.add(authRepository);
  }

  static get<D>() {
    for (var item in _deps) {
      if (item is D) {
        return item;
      } else {
        throw Exception('dependency not found');
      }
    }
  }
}
