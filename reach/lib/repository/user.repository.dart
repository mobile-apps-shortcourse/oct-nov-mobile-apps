import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reach/model/user.dart';

abstract class BaseUserRepository {
  /// update user
  Future<void> updateUser({required UserAccount account});

  Stream<UserAccount?> currentUser();
}

/// implementation of [BaseUserRepository]
class UserRepository implements BaseUserRepository {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  Future<void> updateUser({required UserAccount account}) async {
    if (_auth.currentUser == null) return;

    /// reference to user document
    var userDoc = _db.collection('users').doc(account.id);
    await userDoc.set(account.toJson(), SetOptions(merge: true));
  }

  @override
  Stream<UserAccount?> currentUser() async* {
    var firebaseUser = _auth.currentUser;

    /// user is not signed in yet
    if (firebaseUser == null) yield* const Stream.empty();

    /// user is signed in, get user data from database
    var userStream = _db
        .collection('users')
        .doc(firebaseUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.exists && snapshot.data() != null
            ? UserAccount.fromJson(snapshot.data()!)
            : null);

    yield* userStream;
  }
}
