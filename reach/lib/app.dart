import 'package:flutter/material.dart';
import 'package:reach/presentation/pages/splash.dart';

class ReachApp extends StatelessWidget {
  const ReachApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}
