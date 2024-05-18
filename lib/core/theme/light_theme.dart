import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: false,
  fontFamily: 'Poppins',
  primaryColor: const Color(0xFF2f9870),
  primaryColorLight: const Color(0xFFffffff),
  primaryColorDark: const Color(0xFF0f5256),
  secondaryHeaderColor: const Color(0xFF5f6977),
  disabledColor: const Color(0xFF8797AB),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  brightness: Brightness.light,
  hintColor: const Color(0xFFa2caba),
  focusColor: const Color(0xFFFEFEFE),
  hoverColor: const Color(0xFFF8FAFC),
  shadowColor: const Color(0xFFD1D5DB),
  cardColor: const Color(0xFFFFFFFF),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF69ba6b))),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2f9870),
    secondary: Color(0xFF00756a),
    tertiary: Color(0xFF0f5256),
    onSecondaryContainer: Color(0xFFf0f3f4),
    error: Color(0xFFe74d46),
    onPrimary: Color(0xFF0f5256),
  ).copyWith(background: const Color(0xffFCFCFC)),
);
