/// user type
enum UserType { audience, influencer, brand, none }

/// extensions on [UserType]
extension UserTypeX on UserType {
  String get name => toString().replaceAll('UserType.', '');
}

/// base user props
abstract class BaseUser {
  late String username;
  late String email;
  late UserType userType;
  late String? avatar;
  late int lastLoginDate;

  String get fullName;
}
