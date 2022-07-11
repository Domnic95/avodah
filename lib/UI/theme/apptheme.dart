import 'package:flutter/material.dart';
import 'dart:math';

const Color primaryColor = Color(0xff1e1c49);

// MaterialColor primarySwatch = MaterialColor(
//   0xffD99C8C,
//   <int, Color>{
//     50: Color(0xFFF7BEB0),
//     100: Color(0xFFEEB0A1),
//     200: Color(0xFFE4A393),
//     300: Color(0xFFE9A897),
//     400: Color(0xFFE2A292),
//     500: Color(0xFFC58B7D),
//     600: Color(0xFFD39282),
//     700: Color(0xFFCA8978),
//     800: Color(0xFFD39586),
//     900: Color(0xFFB36F5E),
//   },
// );
MaterialColor primarySwatch = generateMaterialColor(primaryColor);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
