import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: UIColors.black, //Colore di background generale
    splashColor: Colors.white,
    highlightColor: Colors.transparent,
    primaryColor: Colors.white, //Colore generale di tutti i testi
    primaryColorDark: Colors.black,
    backgroundColor: const Color(0xff161616),
    cardColor: const Color(0xff161616), //Colore generale di tutti i bottoni
    unselectedWidgetColor: Colors.white.withOpacity(0.3),
    hoverColor: Colors.white, //const Color(0xff303134),
    dividerColor: UIColors.platinium.withOpacity(0.4),
    canvasColor: Colors.black, //apple button color
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor:
        const Color(0xffF3F7FA), //Colore di background generale
    splashColor: UIColors.grey.withOpacity(0.3),
    highlightColor: Colors.transparent,
    backgroundColor: const Color(0xffF3F7FA),
    primaryColor: Colors.black, //Colore generale di tutti i testi
    primaryColorDark: Colors.black,
    cardColor:
        UIColors.grey.withOpacity(0.3), //Colore generale di tutti i bottoni
    unselectedWidgetColor: UIColors.grey,
    hoverColor: Colors.black,
    dividerColor: UIColors.platinium,
    canvasColor: Colors.white, //apple button color
  );
}
