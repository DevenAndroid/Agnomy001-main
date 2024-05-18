import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  useMaterial3: false,
  fontFamily: 'Poppins',
  primaryColor: const Color(0xFF4fac6e),
  primaryColorLight: const Color(0xFFF0F4F8),
  primaryColorDark: const Color(0xFF0f5256),
  secondaryHeaderColor: const Color(0xFF1f8e70),
  disabledColor: const Color(0xFF8797AB),
  scaffoldBackgroundColor: const Color(0xFF151515),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFC0BFBF),
  focusColor: const Color(0xFF484848),
  hoverColor: const Color(0x400461A5),
  shadowColor: const Color(0x33e2f1ff),
  cardColor: const Color(0xFF10324A),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFFFFFFFF))),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF4fac6e),
    secondary: Color(0xFF2f9870),
    onSecondaryContainer: Color(0xFF02AA05),
    tertiary: (Color(0xFFe74d46)),
    error: (Color(0xFFe74d46)),
    onPrimary: Color(0xff0f5256),
  ).copyWith(background: const Color(0xFF69ba6b)),
);

// semi-dark-light-color