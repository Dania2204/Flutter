import 'package:flutter/material.dart';

class PaeGoColors {
  static const sky     = Color(0xFF23A6F0);
  static const skyDeep = Color(0xFF0D8ED8);
  static const acidGreen = Color(0xFF39FF14);
  static const lightBg = Color(0xFFF2F8FF);
  static const darkBg  = Color(0xFF0D1B2A);
}

ThemeData buildPaeGoLightTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: PaeGoColors.sky,
    brightness: Brightness.light,
    surface: Colors.white,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: PaeGoColors.lightBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF12344D),
      centerTitle: false,
      elevation: 3,
      shadowColor: Color(0x22000000),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: PaeGoColors.sky,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      selectedColor: PaeGoColors.sky.withOpacity(0.2),
      backgroundColor: const Color(0xFFEDF6FF),
      labelStyle: const TextStyle(color: Color(0xFF12344D)),
      secondaryLabelStyle: const TextStyle(color: Color(0xFF12344D)),
      side: const BorderSide(color: Color(0xFFB8D7ED)),
    ),
  );
}

ThemeData buildPaeGoDarkTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: PaeGoColors.sky,
    brightness: Brightness.dark,
    surface: const Color(0xFF12273A),
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: PaeGoColors.darkBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF12273A),
      foregroundColor: Color(0xFFECF7FF),
      centerTitle: false,
      elevation: 3,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: PaeGoColors.sky,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF12273A),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      selectedColor: PaeGoColors.sky.withOpacity(0.35),
      backgroundColor: const Color(0xFF16344F),
      labelStyle: const TextStyle(color: Color(0xFFE6F5FF)),
      secondaryLabelStyle: const TextStyle(color: Color(0xFFE6F5FF)),
      side: const BorderSide(color: Color(0xFF376385)),
    ),
  );
}
