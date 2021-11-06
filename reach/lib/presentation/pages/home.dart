import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reach/bloc/user_cubit.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/injector.dart';
import 'package:reach/config/extensions.dart';
import 'package:reach/model/user.dart';

part 'audience/dashboard.audience.dart';
part 'brand/dashboard.brand.dart';
part 'influencer/dashboard.influencer.dart';

/// renderes the right page for the current user
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userCubit = UserCubit(repository: Injector.get());
  UserType? _accountType;
  bool _loading = false;
  UserAccount? _currentUser;

  @override
  void dispose() {
    _userCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _userCubit.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _userCubit,
      listener: (context, state) {
        if (mounted) setState(() => _loading = state is UserLoading);

        if (state is UserSuccess<UserAccount> &&
            mounted &&
            state.data != null) {
          setState(() {
            _currentUser = state.data;
            _accountType = state.data!.userType;
          });
        }

        logger.i('account type -> $_accountType & user -> $_currentUser');

        if (state is UserError && mounted) {
          context.showSnackBar(state.reason);
        }
      },
      child: Scaffold(
        body: _loading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _accountType == UserType.brand
                ? const BrandDashboard()
                : _accountType == UserType.influencer
                    ? const InfluencerDashboard()
                    : const AudienceHome(),
      ),
    );
  }
}
