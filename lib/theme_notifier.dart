import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(
    this._themeData,
  );

  //bool darkThemeSelected = false;

  getTheme() {
    return _themeData;
  }

  getThemeBool() {
    if (_themeData == darkTheme) {
      return true;
    }
    return false;
  }

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  toggleTheme(bool val) async {
    //darkThemeSelected = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', val);
    if (val) {
      setTheme(darkTheme);
    } else {
      setTheme(lightTheme);
    }
    notifyListeners();
  }

  SystemUiOverlayStyle getSystemOverlayStyle() {
    if (getTheme() == darkTheme) {
      return SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      );
    } else {
      return SystemUiOverlayStyle(
        statusBarColor: Colors
            .transparent, // set back to white if there are any problems with status bar
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
    }
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey.withOpacity(.1),
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  accentColor: Color(0xFFFEFEFE),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.grey[700],
  bottomAppBarColor: Colors.black,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade800,
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
);

final lightTheme = ThemeData(
  textSelectionColor: Colors.purple,
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFFFEFEFE),
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Colors.blueAccent,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.grey,
  scaffoldBackgroundColor: Color(0xFFFEFEFE),
);
