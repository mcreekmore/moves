import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:provider/provider.dart';
import 'dart:io';

class AppTheme {
  AppTheme();

  bool darkThemeSelected = false;

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  /////////////////
  /* LIGHT THEME */
  /////////////////

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  ////////////////
  /* DARK THEME */
  ////////////////
  static const TextTheme textThemeDark = TextTheme(
    display1: display1Dark,
    headline: headlineDark,
    title: titleDark,
    subtitle: subtitleDark,
    body2: body2Dark,
    body1: body1Dark,
    caption: captionDark,
  );

  static const TextStyle display1Dark = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyBlack,
  );

  static const TextStyle headlineDark = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: nearlyBlack,
  );

  static const TextStyle titleDark = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: nearlyBlack,
  );

  static const TextStyle subtitleDark = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: nearlyBlack,
  );

  static const TextStyle body2Dark = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: nearlyBlack,
  );

  static const TextStyle body1Dark = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: nearlyBlack,
  );

  static const TextStyle captionDark = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: nearlyBlack, // was lightText
  );

  SystemUiOverlayStyle getSystemOverlayStyle() {
    if (darkThemeSelected) {
      return SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.light : Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      );
    } else {
      return SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
    }
  }

  void toggleTheme() {
    darkThemeSelected = !darkThemeSelected;
  }

  TextTheme getTextTheme() {
    if (darkThemeSelected) {
      return textThemeDark;
    } else {
      return textTheme;
    }
  }

  Color getContainerColor() {
    if (darkThemeSelected) {
      return black;
    } else {
      return nearlyWhite;
    }
  }

  Color getTextColor() {
    if (darkThemeSelected) {
      return lightText;
    } else {
      return darkText;
    }
  }

  Color getIconColor() {
    if (darkThemeSelected) {
      return nearlyWhite;
    } else {
      return dark_grey;
    }
  }

  Color getDrawerColor() {
    if (darkThemeSelected) {
      return Colors.black87;
    } else {
      return notWhite.withOpacity(0.5);
    }
  }

  Color getDrawerIconShadow() {
    if (darkThemeSelected) {
      return nearlyWhite.withOpacity(0.2);
    } else {
      return grey.withOpacity(0.6);
    }
  }

  Color getDrawerTextColor() {
    if (darkThemeSelected) {
      return nearlyWhite;
    } else {
      return grey;
    }
  }

  Color getDrawerBottomTextColor() {
    if (darkThemeSelected) {
      return nearlyWhite;
    } else {
      return darkText;
    }
  }

  Color getDrawerBodyTextColor() {
    if (darkThemeSelected) {
      return nearlyWhite;
    } else {
      return darkText;
    }
  }

  Color getDrawerListItemColor() {
    if (darkThemeSelected) {
      return nearlyWhite;
    } else {
      return Colors.blue;
    }
  }

  Color getDrawerDividerColor() {
    if (darkThemeSelected) {
      return nearlyWhite.withOpacity(0.6);
    } else {
      return grey.withOpacity(0.6);
    }
  }
}
