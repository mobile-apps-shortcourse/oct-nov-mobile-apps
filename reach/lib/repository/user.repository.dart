import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reach/config/injector.dart';
import 'package:reach/model/user.dart';
import 'package:reach/repository/persistent.storage.repository.dart';

abstract class BaseUserRepository {
  /// update user
  Future<void> updateUser({required UserAccount account});

  Stream<UserAccount?> currentUser();
}

/// implementation of [BaseUserRepository]
class UserRepository implements BaseUserRepository {
  final PersistentStorageRepository storageRepo;
  final _db = dependencyProvider.read(firebaseFirestoreProvider);

  UserRepository({required this.storageRepo});

  @override
  Future<void> updateUser({required UserAccount account}) async {
    if (!storageRepo.isLoggedIn) return;

    /// reference to user document
    var userDoc = _db.collection('users').doc(account.id);
    await userDoc.set(account.toJson(), SetOptions(merge: true));
  }

  @override
  Stream<UserAccount?> currentUser() async* {
    /// user is not signed in yet
    if (!storageRepo.isLoggedIn) yield* const Stream.empty();

    /// user is signed in, get user data from database
    var userStream = _db
        .collection('users')
        .doc(storageRepo.userId!)
        .snapshots()
        .map((snapshot) => snapshot.exists && snapshot.data() != null
            ? UserAccount.fromJson(snapshot.data()!)
            : null);

    yield* userStream;
  }
}
