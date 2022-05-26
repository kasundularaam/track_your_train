import 'package:flutter/material.dart';

class AppTheme {
  static const int _bluePrimaryValue = 0xFF0022CA;
  static const MaterialColor _blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFF0022CA),
      100: Color(0xFF0022CA),
      200: Color(0xFF0022CA),
      300: Color(0xFF0022CA),
      400: Color(0xFF0022CA),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF0022CA),
      700: Color(0xFF0022CA),
      800: Color(0xFF0022CA),
      900: Color(0xFF0022CA),
    },
  );
  const AppTheme._();
  static final lightTheme = ThemeData(
    primarySwatch: _blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: _blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
