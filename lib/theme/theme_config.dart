import 'package:flutter/material.dart';

class ThemeConfig {
  // Базовые цвета для обеих тем
  static const Color _primaryLight = Color(0xFF4B9FE1);
  static const Color _primaryDark = Color(0xFF1A237E);
  static const Color _textLight = Color(0xFF2E3E6D);
  static const Color _textDark = Colors.white;

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
      onPrimary: Colors.white,
      secondary: _textLight,
      surface: Colors.white,
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
      onPrimary: Colors.white,
      secondary: _textDark,
      surface: const Color(0xFF333333),
      onSurface: _textDark,
    ),
  );

}