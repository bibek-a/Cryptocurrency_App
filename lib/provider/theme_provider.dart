import 'package:flutter/material.dart';

class themeProvider with ChangeNotifier {
  //
  ThemeMode themeMode = ThemeMode.light;
  toggleTheme() {
    //
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
