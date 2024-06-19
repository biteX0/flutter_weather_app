import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/screens/auth/login_screen.dart';
import 'package:weather/screens/home/home_screen.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  Future singInn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim());
    } catch (error) {
      Get.snackbar('Ошибка', 'Пользователь не найден');
    }
  }

  Future singUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.value.text.trim(),
            password: passwordController.value.text.trim());
        Get.to(HomeScreen());
      } catch (error) {
        Get.snackbar('Ошибка', 'Данный аккаунт уже существует');
      }
    }
  }

  bool passwordConfirmed() {
    if (passwordController.value.text.trim() ==
        confirmPasswordController.value.text.trim()) {
      return true;
    } else {
      Get.snackbar('Ошибка', 'Пароли не совпадают');
      return false;
    }
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.value.text.trim());
      Get.snackbar(
          'Письмо для сброса пароля отправлено: ', emailController.value.text);
    } on FirebaseAuthException catch (error) {
      print(error);
      Get.snackbar('Ошибка', error.message.toString());
    }
  }
}
