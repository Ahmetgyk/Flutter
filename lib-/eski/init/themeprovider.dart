import 'package:flutter/material.dart';

class CostumThemeData extends ChangeNotifier{
  ThemeData _themeData = ThemeData();

  ThemeData get getThemeData => _themeData;

  void setThemeData (ThemeData data) {
    _themeData = data;
    notifyListeners();
  }
}