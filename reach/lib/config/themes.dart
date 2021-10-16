import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// colors (hexadecimals -> 0-9, A-F)
// 0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
const _kPink50 = Color(0xfffeeae6);
const _kPink100 = Color(0xfffedbd0);
const _kPink900 = Color(0xff442c2e);
const _kError = Color(0xffe30425);
const _kWhite = Colors.white;
const _kBlack = Colors.black;

// fonts
TextTheme _kDefaultTextTheme(BuildContext context) {
  var brightness = Theme.of(context).brightness;
  var textColor = brightness == Brightness.dark ? _kWhite : _kPink900;
  var buttonTextColor = _kPink900;

  return GoogleFonts.rubikTextTheme().copyWith(
    headline1: GoogleFonts.rubik(
      fontSize: 98,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: textColor,
    ),
    headline2: GoogleFonts.rubik(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: textColor,
    ),
    headline3: GoogleFonts.rubik(
      fontSize: 49,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),
    headline4: GoogleFonts.rubik(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: textColor,
    ),
    headline5: GoogleFonts.rubik(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
    headline6: GoogleFonts.rubik(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: textColor,
    ),
    subtitle1: GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: textColor,
    ),
    subtitle2: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: textColor,
    ),
    bodyText1: GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: textColor,
    ),
    bodyText2: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: textColor,
    ),
    button: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: buttonTextColor,
    ),
    caption: GoogleFonts.rubik(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: textColor,
    ),
    overline: GoogleFonts.rubik(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: textColor,
    ),
  );
}

// theme modes
ThemeData kLightTheme(BuildContext context) => ThemeData.light().copyWith(
      scaffoldBackgroundColor: _kPink50,
      colorScheme: const ColorScheme.light().copyWith(
        primary: _kPink100,
        primaryVariant: _kPink900,
        onPrimary: _kPink900,
        secondary: _kPink100,
        secondaryVariant: _kPink100,
        onSecondary: _kPink900,
        error: _kError,
        onError: _kWhite,
        background: _kPink50,
        onBackground: _kPink900,
        surface: _kPink50,
        onSurface: _kPink900,
      ),
      textTheme: _kDefaultTextTheme(context),
    );

ThemeData kDarkTheme(BuildContext context) => ThemeData.dark().copyWith(
      textTheme: _kDefaultTextTheme(context),
      colorScheme: const ColorScheme.dark().copyWith(
          // primary: ,
          // primaryVariant: ,
          // onPrimary: ,
          // secondary: ,
          // secondaryVariant: ,
          // onSecondary: ,
          // error: ,
          // onError: ,
          // background: ,
          // onBackground: ,
          // surface: ,
          // onSurface: ,
          ),
    );

// update system chrome
void kApplySystemOverlay(
  BuildContext context, {
  Color? statusBarColor,
  Color? systemNavigationBarColor,
  Color? systemNavigationBarDividerColor,
  Brightness statusBarIconBrightness = Brightness.dark,
  Brightness systemNavigationBarIconBrightness = Brightness.dark,
}) {
  // get the current theme of the application
  var currentTheme = Theme.of(context);
  var colorScheme = currentTheme.colorScheme;

  // apply the theme overlay
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? colorScheme.background,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor:
          systemNavigationBarColor ?? colorScheme.background,
      systemNavigationBarDividerColor:
          systemNavigationBarDividerColor ?? colorScheme.background,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
    ),
  );
}
