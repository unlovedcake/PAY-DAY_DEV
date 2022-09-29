// ignore_for_file: unused_import

import 'package:flutter/material.dart';

Color gkGetColor(String colorName){
  Color returnedColor;
  switch (colorName) {
    case "pdyGreenTheme":
      returnedColor = const Color(0xFF86A16A);
      break;
    case "gkBGTheme":
      returnedColor = const Color(0xFF124D6D);
      break;
    case "gkSkyBlue":
      returnedColor = const Color(0xFF3BBDD5);
      break;
    case "gkBtnColor":
      returnedColor = const Color(0xFF59C4DC);
      break;
    default:
      returnedColor = Colors.black;
      break;
  }
  return returnedColor;
}