import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// user type
enum UserType { brand, audience, influencer, unknown }

/// user data model
@CopyWith()
@JsonSerializable()
class UserAccount {
  final String id;
  final String username;
  final String? avatar;
  final String email;
  final UserType userType;
  final int lastLoginDate;
  final int createdOn;

  UserAccount({
    required this.id,
    required this.username,
    required this.email,
    required this.lastLoginDate,
    required this.createdOn,
    this.userType = UserType.unknown,
    this.avatar,
  });

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);


}
