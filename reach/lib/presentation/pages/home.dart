import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reach/bloc/user_cubit.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/injector.dart';
import 'package:reach/config/extensions.dart';
import 'package:reach/config/themes.dart';
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
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var kTheme = Theme.of(context);

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;

    /// set system UI overlays when the application is rendered
    /// to the user's display.
    kApplySystemOverlay(
      context,
      statusBarColor: colorScheme.background,
      statusBarIconBrightness: kTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarIconBrightness: kTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );

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
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        extendBodyBehindAppBar: false,
        body: _loading || _accountType == null
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SizedBox.expand(
                child: _accountType == UserType.brand
                    ? const BrandDashboard()
                    : _accountType == UserType.influencer
                        ? const InfluencerDashboard()
                        : const AudienceHome(),
              ),
        bottomNavigationBar: Container(
          width: width,
          height: kBottomNavigationBarHeight,
          color: colorScheme.background.withOpacity(0.1),
        ),
        extendBody: false,
      ),
    );
  }
}
