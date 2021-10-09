import 'package:flutter/material.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/pages/splash.dart';

class ReachApp extends StatelessWidget {
  const ReachApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kLightTheme(context),
      darkTheme: kDarkTheme(context),
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}
