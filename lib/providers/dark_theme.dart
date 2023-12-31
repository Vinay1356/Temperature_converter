import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {

  var _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;


  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}