import 'package:flutter/material.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

class ThemeX {
  static final darkTheme = ThemeData(
    bottomAppBarColor: COLOR_CONST.BLACK100,
    primaryColor: COLOR_CONST.DEFAULT100,
    disabledColor: COLOR_CONST.WHITE50,
    indicatorColor: COLOR_CONST.WHITE80, // usato come testo
    scaffoldBackgroundColor: COLOR_CONST.BLACK80,

//    scaffoldBackgroundColor: COLOR_CONST.BLACK, //Colore di background generale
    splashColor: Colors.white,
    highlightColor: Colors.transparent,
    primaryColorDark: Colors.black,
    backgroundColor: const Color(0xff161616),
    cardColor: const Color(0xff161616), //Colore generale di tutti i bottoni
    unselectedWidgetColor: Colors.white.withOpacity(0.3),
    //hoverColor: Colors.white, //const Color(0xff303134),
    // dividerColor: COLOR_CONST.BLUE,
    canvasColor: Colors.black, //apple button color
  );

  static final lightTheme = ThemeData(
    bottomAppBarColor: COLOR_CONST.WHITE100,
    primaryColor: COLOR_CONST.DEFAULT100,
    disabledColor: COLOR_CONST.BLACK50,
    indicatorColor: COLOR_CONST.BLACK80,
    scaffoldBackgroundColor: COLOR_CONST.WHITE80,
    //splashColor: COLOR_CONST.GREEN,
    highlightColor: Colors.transparent,
    backgroundColor: const Color(0xffF3F7FA),
    primaryColorDark: Colors.black,
    //  cardColor: COLOR_CONST.FACEBOOK_BTN, //Colore generale di tutti i bottoni
    unselectedWidgetColor: COLOR_CONST.DEFAULT100,
    hoverColor: Colors.black,
    //dividerColor: COLOR_CONST.FACEBOOK_BORDER_BTN,
    canvasColor: Colors.white, //apple button color
  );
}
