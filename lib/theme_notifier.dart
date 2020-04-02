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
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.grey,
  bottomAppBarColor: Colors.black,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFFFEFEFE),
  brightness: Brightness.light,
  backgroundColor: Colors.black,
  accentColor: Colors.blueAccent,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.grey,
);

bool darkThemeSelected = true;

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() {
    return _themeData;
  }

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
