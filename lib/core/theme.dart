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
    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    backgroundColor: const Color(0xff161616),
    cardColor: UIColors.lowTransaprentWhite, //const Color(0xff303134),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF3F7FA),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    backgroundColor: const Color(0xffF3F7FA),
    primaryColor: Colors.black,
    primaryColorDark: Colors.black,
    cardColor: UIColors.grey.withOpacity(0.3),
  );
}
