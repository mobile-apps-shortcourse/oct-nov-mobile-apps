import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slackui/home.page.dart';

/// colors
const kPrimaryColor = Color(0xff4A154B);
const kSecondaryColor = Color(0xffE01E5A);
final kDefaultTextStyle = GoogleFonts.rubikTextTheme();

/// application instance.
/// this is the root of all widgets in the app
class SlackApp extends StatelessWidget {
  const SlackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: const HomePage(),
        theme: ThemeData.light().copyWith(
          textTheme: kDefaultTextStyle,
          colorScheme: ColorScheme.light(
            primary: kPrimaryColor,
            secondary: kSecondaryColor,
            onSecondary: Colors.white,
            onPrimary: Colors.white,
            surface: Colors.grey.withOpacity(0.2),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
          ),
        ),
      );
}
