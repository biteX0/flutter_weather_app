import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/screens/auth/auth_controller.dart';

class ResetPasswordScreen extends GetView<AuthController> {
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 25, left: 20, right: 20),
            child: Text(
              textAlign: TextAlign.center,
              'Введите свой email для сброса  пароля',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  controller: controller.emailController.value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Адрес эл. почты',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: controller.passwordReset,
                  child: Text('Сброс пароля'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                )),
          )
        ],
      ),
    );
  }
}
