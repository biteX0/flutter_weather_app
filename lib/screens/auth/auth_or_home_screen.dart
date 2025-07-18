import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/screens/auth/login_screen.dart';
import 'package:weather/screens/home/home_screen.dart';

class AuthOrLoadingHomeScreen extends GetView<AuthController> {
  const AuthOrLoadingHomeScreen({super.key});
// Загрузка экрана с вводом логина и пароля, если ранее вход не был выполнен

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSignedIn.value) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    });
  }
}
