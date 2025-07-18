import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/routing/app_routes.dart';
import 'package:weather/snackbar_error_messages/barrel_file_snackbar.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  RxBool isSignedIn = false.obs;
  StreamSubscription<User?>? _authStateSubscription;

  @override
  void onInit() {
    super.onInit();
    _authStateSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        isSignedIn.value = true;
      } else {
        isSignedIn.value = false;
      }
    });
  }

  @override
  void onClose() {
    _authStateSubscription?.cancel();
    super.onClose();
  }

//Очищаем поля после успешных операций
  void clearFields() {
    emailController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
  }

  Future singInn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim());
      clearFields();
    } catch (error) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.userNotFound),
      );
    }
  }

  Future singUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.value.text.trim(),
            password: passwordController.value.text.trim());
        Get.offAllNamed(Routes.mainPage);
        clearFields();
      } catch (error) {
        SnackbarManager.showAppSnackBar(
          PredefinedMessage(SnackBarMessages.accountExists),
        );
      }
    }
  }

  bool passwordConfirmed() {
    if (passwordController.value.text.trim() ==
        confirmPasswordController.value.text.trim()) {
      return true;
    } else {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.passwordsDontMatch),
      );
      return false;
    }
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.value.text.trim());
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.emailSend),
      );
      clearFields();
    } on FirebaseAuthException catch (error) {
      print(error);
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.errorResetPassword),
      );
    }
  }
}
