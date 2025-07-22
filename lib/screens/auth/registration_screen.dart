import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/models/text_field_data.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/widgets/custom_button.dart';
import 'package:weather/widgets/custom_text_field.dart';
import 'package:weather/widgets/background_widget.dart';

class RegistrationScreen extends GetView<AuthController> {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final fields = [
      TextFieldData(
        textController: controller.emailController.value,
        hintText: 'Адрес эл. почты',
      ),
      TextFieldData(
        textController: controller.passwordController.value,
        hintText: 'Пароль',
        isPassword: true,
      ),
      TextFieldData(
        textController: controller.confirmPasswordController.value,
        hintText: 'Подтвердите пароль',
        isPassword: true,
      ),
    ];

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Регистрация',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    ...fields.map(
                      (field) => Obx(
                        () => CustomTextField(
                          textController: field.textController,
                          hintText: field.hintText,
                          obscureText: field.obscureText.value,
                          suffixIcon: field.suffixIcon,
                          isPassword: field.isPassword,
                          onPressVisibilityPassword:
                              field.toggleObscurePassword,
                        ),
                      ),
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
        ],
      ),
    );
  }
}
