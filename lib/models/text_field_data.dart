import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TextFieldData {
  final TextEditingController textController;
  final String hintText;
  RxBool obscureText;
  final Widget? suffixIcon;
  final bool isPassword;
  final VoidCallback? onPressVisibilityPassword;


  TextFieldData({
    required this.textController,
    required this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.onPressVisibilityPassword,
  }) : obscureText = (isPassword ? true : false).obs;

  // Скрыть/показать пароль
  toggleObscurePassword() {
    if (isPassword) {
      obscureText.value = !obscureText.value;
    }
  }
}
