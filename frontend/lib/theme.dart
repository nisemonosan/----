import 'package:flutter/material.dart';

// ライトモード
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFe9f1f7),
  colorScheme: ColorScheme.light(
    surface: Color(0xFFdce4ea),
    primary: Color(0xFF2274A5),
    secondary: Colors.yellow,
  ),
  fontFamily: 'LINESeed'
);

// ダークモード
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFFe9f1f7),
  colorScheme: ColorScheme.dark(
    surface: Color(0xFFdce4ea),
    primary: Color(0xFF2274A5),
    secondary: Colors.yellow
  ),
);