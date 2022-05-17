import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: UIColors.black,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF3F7FA),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
