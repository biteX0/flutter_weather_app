import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeService extends GetxService {
  static const String _themeKey = 'isDarkMode';
  final _isDarkTheme = false.obs;
  
  bool get isDarkTheme => _isDarkTheme.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  // Загрузка сохраненной темы при старте
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme.value = prefs.getBool(_themeKey) ?? false;
    await _updateTheme();
  }

  // Переключение темы
  Future<void> toggleTheme() async {
    _isDarkTheme.value = !_isDarkTheme.value;
    await _updateTheme();
    
    // Сохраняем выбор пользователя
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkTheme.value);
  }

  // Обновление темы приложения и системных UI элементов
  Future<void> _updateTheme() async {
    Get.changeThemeMode(_isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);

    if (Platform.isAndroid) {
      final color = _isDarkTheme.value ? Colors.black : Colors.white;
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarIconBrightness:
              _isDarkTheme.value ? Brightness.light : Brightness.dark,
          systemNavigationBarDividerColor: color,
          systemNavigationBarColor: color,
          statusBarIconBrightness: 
              _isDarkTheme.value ? Brightness.light : Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      );
    }
  }
}
