import 'package:flutter/material.dart';

class ThemeConfig {
  static const Color _primaryLight = Color.fromARGB(255, 75, 159, 225);
  static const Color _primaryDark = Color.fromARGB(255, 26, 35, 126);
  static const Color _textLight = Color.fromARGB(255, 14, 20, 40);
  static const Color _textDark = Color.fromARGB(255, 229, 228, 228);

  static const double _fontSizeTitle = 30.0;
  static const double _fontSizeBody = 16.0;
  static const double _fontSizeLabel = 14.0;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryLight,
    fontFamily: 'Lato',
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
      surface: const Color.fromARGB(149, 255, 255, 255),
      onSurface: _textLight,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryDark,
    fontFamily: 'Lato',
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
      surface: const Color.fromARGB(33, 255, 254, 254),
      onSurface: _textDark,
    ),
  );
}

class AppGradients {
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: const [
      Color.fromARGB(255, 40, 47, 83),
      Color.fromARGB(255, 18, 27, 48),
      Color.fromARGB(255, 0, 3, 20),
    ],
  );

  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 192, 198, 202),
      Color.fromARGB(255, 119, 155, 187),
      Color.fromARGB(255, 25, 56, 99),
    ],
  );
}
