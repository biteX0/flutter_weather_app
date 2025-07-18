import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/widgets/custom_button.dart';
import 'package:weather/widgets/custom_text_field.dart';
import 'package:weather/widgets/background_widget.dart';

class ResetPasswordScreen extends GetView<AuthController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
       WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearFields();
    });

    final theme = Theme.of(context);
    return Stack(
      children: [
        const BackgroundWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Сброс пароля',
                    style: theme.textTheme.titleLarge,
                  )),
              CustomTextField(
                textController: controller.confirmPasswordController.value,
                hintText: 'Адрес эл. почты',
              ),
              CustomButton(
                text: 'Сброс пароля',
                onPressed: controller.passwordReset,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
