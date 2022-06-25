import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: UIColors.black,
    splashColor: Colors.white,
    highlightColor: Colors.transparent,
    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    backgroundColor: const Color(0xff161616),
    cardColor: const Color(0xff161616),
    unselectedWidgetColor: Colors.white.withOpacity(0.3),
    hoverColor: Colors.white, //const Color(0xff303134),
    dividerColor: UIColors.platinium.withOpacity(0.4),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF3F7FA),
    splashColor: Colors.white.withOpacity(0.3),
    highlightColor: Colors.transparent,
    backgroundColor: const Color(0xffF3F7FA),
    primaryColor: Colors.black,
    primaryColorDark: Colors.black,
    cardColor: UIColors.grey.withOpacity(0.3),
    unselectedWidgetColor: UIColors.grey,
    hoverColor: Colors.black,
    dividerColor: UIColors.platinium,
  );
}
