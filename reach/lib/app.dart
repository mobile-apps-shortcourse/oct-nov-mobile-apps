import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reach/config/dependency.injection.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/blocs/auth_cubit.dart';
import 'package:reach/presentation/blocs/user_cubit.dart';
import 'package:reach/presentation/pages/splash.dart';

/// root application instance for the flutter app.
/// this is the parent widget of the entire application and is
/// responsible for managing the theme, pages and more.
class ReachApp extends StatefulWidget {
  const ReachApp({Key? key}) : super(key: key);

  @override
  State<ReachApp> createState() => _ReachAppState();
}

class _ReachAppState extends State<ReachApp> {
  final _authCubit = AuthCubit(repository: Injector.get());
  final _userCubit = UserCubit(repository: Injector.get());

  @override
  void dispose() {
    _authCubit.close();
    _userCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => _authCubit,
        ),
        BlocProvider<UserCubit>(
          create: (context) => _userCubit,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kLightTheme(context),
        darkTheme: kDarkTheme(context),
        themeMode: ThemeMode.system,
        home: const SplashPage(),
      ),
    );
  }
}
