import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/routing/app_routes.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/theme/theme_service.dart';
import 'package:weather/widgets/custom_button.dart';
import 'package:weather/widgets/custom_text_field.dart';
import 'package:weather/widgets/background_widget.dart';

class RegistrationScreen extends GetView<AuthController> {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BackgroundWidget(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child:
                            Text('Регистрация', 
                          style: theme.textTheme.titleLarge,
                            ),
                      ),
                      CustomTextField(
                        textController: controller.emailController.value,
                        hintText: 'Адрес эл. почты',
                      ),
                      CustomTextField(
                        textController: controller.passwordController.value,
                        hintText: 'Пароль',
                        obscureText: true,
                      ),
                      CustomTextField(
                        textController: controller.confirmPasswordController.value,
                        hintText: 'Подтвердите пароль',
                        obscureText: true,
                      ),
                      CustomButton(
                        text: 'Регистрация',
                        onPressed: controller.singUp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
