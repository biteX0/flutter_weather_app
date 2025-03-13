import 'package:flutter/material.dart';

class ThemeConfig {
  // Базовые цвета для обеих тем
  static const Color _primaryLight = Color.fromARGB(255, 75, 159, 225);
  static const Color _primaryDark = Color.fromARGB(255, 26, 35, 126);
  static const Color _textLight = Color.fromARGB(255, 46, 62, 109);
  static const Color _textDark = Color.fromARGB(255, 229, 228, 228);

  // Размеры текста (можно вынести в отдельный класс TextSizes если будут использоваться в других местах)
  static const double _fontSizeTitle = 30.0;
  static const double _fontSizeBody = 16.0;
  static const double _fontSizeLabel = 14.0;

  // Светлая тема
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryLight,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _textLight),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: _fontSizeTitle,
        color: _textLight,
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      bodyMedium: TextStyle(
        fontSize: _fontSizeBody,
        color: _textLight,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        fontSize: _fontSizeLabel,
        color: _textLight,
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: _primaryLight,
      onPrimary: const Color.fromARGB(255, 223, 220, 220),
      secondary: _textLight,
      surface: const Color.fromARGB(255, 223, 220, 220),
      onSurface: _textLight,
    ),
  );

  // Темная тема
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryDark,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _textDark),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: _fontSizeTitle,
        color: _textDark,
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      bodyMedium: TextStyle(
        fontSize: _fontSizeBody,
        color: _textDark,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        fontSize: _fontSizeLabel,
        color: _textDark,
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: _primaryDark,
      onPrimary: const Color.fromARGB(255, 223, 220, 220),
      secondary: _textDark,
      surface: const Color.fromARGB(255, 51, 51, 51),
      onSurface: _textDark,
    ),
  );

}