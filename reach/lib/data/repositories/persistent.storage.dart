import 'dart:async';

import 'package:reach/config/constants.dart';
import 'package:reach/data/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// constants
const _userIdKey = 'user.id.key';
const _userTypeKey = 'user.type.key';

/// persistent storage wrapper
abstract class BasePersistentStorage {
  /// observe login status
  bool get isLoggedIn;

  /// get user id
  String get userId;

  /// get user type
  UserType get userType;

  /// save user login id
  Future<void> saveUserId(String userId);

  /// save user type
  Future<void> saveUserType(UserType userType);

  /// clear all saved preferences
  Future<void> clear();
}

/// implementation of [BasePersistentStorage]
class PersistentStorage extends BasePersistentStorage {
  final SharedPreferences prefs;

  /// controller for login status stream
  final StreamController<bool> _controller = StreamController.broadcast();

  PersistentStorage({required this.prefs}) {
    /// check user login state when started
    var localUserId = prefs.getString(_userIdKey);
    var localUserType = prefs.getString(_userTypeKey);
    logger.i('logged in with -> $localUserId & type -> $localUserType');
    _controller.add(localUserId != null && localUserId.isNotEmpty);
  }

  @override
  Future<void> clear() async => await prefs.clear();

  @override
  Future<void> saveUserId(String userId) async {
    await prefs.setString(_userIdKey, userId);
    _controller.add(userId.isNotEmpty);
  }

  @override
  Future<void> saveUserType(UserType userType) async {
    await prefs.setString(_userTypeKey, userType.name);
  }

  @override
  String get userId => prefs.getString(_userIdKey) ?? '';

  @override
  UserType get userType => UserType.values.singleWhere(
      (element) => element.name == prefs.getString(_userTypeKey),
      orElse: () => UserType.none);

  @override
  bool get isLoggedIn => userId.isNotEmpty;
}
