import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/repository/auth.repository.dart';
import 'package:reach/repository/persistent.storage.repository.dart';
import 'package:reach/repository/user.repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// riverpod dependencies section
final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);
final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

/// provide dependencies using riverpod
final dependencyProvider = ProviderContainer();

/// provide dependencies
class Injector {
  static final _deps = [];

  /// initialize all dependencies
  static Future<void> init() async {
    /// initialize firebase application
    var firebaseApp = await Firebase.initializeApp();

    /// [DEFAULT]
    logger.i('Firebase application initialized as ${firebaseApp.name}');

    /// 1.shared prefs
    var prefs = await SharedPreferences.getInstance();

    /// 2. storage repo
    var storageRepo = PersistentStorageRepository(prefs: prefs);

    /// 3. user repo
    BaseUserRepository userRepo = UserRepository(storageRepo: storageRepo);

    /// 4. auth repo
    BaseAuthRepository authRepo = FirebaseAuthRepository(
      storageRepo: storageRepo,
      userRepo: userRepo,
    );

    /// register dependencies
    _deps
      ..add(storageRepo)
      ..add(userRepo)
      ..add(authRepo);

    logger.i('you have ${_deps.length} dependencies registered successfully');
  }

  /// get a dependency by type
  static T get<T>() {
    for (var dep in _deps) {
      if (dep is T) return dep;
    }
    throw Exception('Unregistered dependency');
  }
}
