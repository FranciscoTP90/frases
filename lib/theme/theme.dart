import 'package:flutter/material.dart';
import 'package:frases/theme/colors.dart';

class ThemeApp {
  static const TextStyle titleTextStyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0);

  static final ThemeData themeDataLight = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: ColorsApp.blue,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: titleTextStyle),
  );
}
