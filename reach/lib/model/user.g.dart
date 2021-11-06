// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserAccountCopyWith on UserAccount {
  UserAccount copyWith({
    String? avatar,
    int? createdOn,
    String? email,
    String? id,
    int? lastLoginDate,
    UserType? userType,
    String? username,
  }) {
    return UserAccount(
      avatar: avatar ?? this.avatar,
      createdOn: createdOn ?? this.createdOn,
      email: email ?? this.email,
      id: id ?? this.id,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      userType: userType ?? this.userType,
      username: username ?? this.username,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      lastLoginDate: json['lastLoginDate'] as int,
      createdOn: json['createdOn'] as int,
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.unknown,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'email': instance.email,
      'userType': _$UserTypeEnumMap[instance.userType],
      'lastLoginDate': instance.lastLoginDate,
      'createdOn': instance.createdOn,
    };

const _$UserTypeEnumMap = {
  UserType.brand: 'brand',
  UserType.audience: 'audience',
  UserType.influencer: 'influencer',
  UserType.unknown: 'unknown',
};
