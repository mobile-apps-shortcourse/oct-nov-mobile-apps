import 'package:flutter/material.dart';
import 'package:reach/bloc/authentication_cubit.dart';
import 'package:reach/model/user.dart';
import 'package:reach/repository/auth.repository.dart';

/// account type wrapper.
/// used to create te account type picker widget
class AccountType {
  final UserType type;
  final String imageUrl;

  AccountType({required this.type, required this.imageUrl});
}

/// user picks account type
class AccountPickerPage extends StatefulWidget {
  const AccountPickerPage({Key? key}) : super(key: key);

  @override
  _AccountPickerPageState createState() => _AccountPickerPageState();
}

class _AccountPickerPageState extends State<AccountPickerPage> {
  final _authCubit = AuthenticationCubit(repository: FirebaseAuthRepository());
  bool _loading = false;
  UserType _selectedUserType = UserType.unknown;
  final _userTypes = <UserType>[
    UserType.influencer,
    UserType.brand,
    UserType.audience,
  ];

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('You are on the account picker page'),
      ),
    );
  }
}
