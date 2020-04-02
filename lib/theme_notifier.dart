import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:provider/provider.dart';
import 'dart:io';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey.withOpacity(.1),
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  accentColor: Color(0xFFFEFEFE),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.grey,
  bottomAppBarColor: Colors.black,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFFFEFEFE),
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Colors.blueAccent,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.grey,
);

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  bool darkThemeSelected = false;

  getTheme() {
    return _themeData;
  }

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  toggleTheme(bool val) {
    darkThemeSelected = val;
    notifyListeners();
  }

  SystemUiOverlayStyle getSystemOverlayStyle() {
    if (darkThemeSelected) {
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
        statusBarColor: Colors.white,
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
