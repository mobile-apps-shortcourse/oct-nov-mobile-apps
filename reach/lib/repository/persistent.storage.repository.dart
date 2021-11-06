import 'package:shared_preferences/shared_preferences.dart';

/// using `shared_preferences` package to store user id and other user preferences
/// to a secure file on the user's device as key-value pairs
/// 'user.id.key' : null || '12343455465757'

class PersistentStorageRepository {
  final SharedPreferences prefs;

  static const String _kUserIdKey = 'user.id.key';

  PersistentStorageRepository({required this.prefs});

  /// get the value of the user id stored on the device and check whether it is not null
  bool get isLoggedIn => userId != null;

  /// get current user's id
  String? get userId => prefs.getString(_kUserIdKey);

  /// save user id to storage
  Future<void> saveUserId(String userId) async =>
      prefs.setString(_kUserIdKey, userId);

  /// clear all data stored locally
  Future<void> clear() async => await prefs.clear();
}
