import 'package:flutter/material.dart';
import 'theme_data.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
