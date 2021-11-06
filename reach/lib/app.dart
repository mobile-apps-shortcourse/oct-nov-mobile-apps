import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/pages/splash.dart';

/// root application instance for the flutter app.
/// this is the parent widget of the entire application and is
/// responsible for managing the theme, pages and more.
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
      scrollBehavior: const CupertinoScrollBehavior(),
    );
  }
}
