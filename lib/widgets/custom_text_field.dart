import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final FocusNode? textFieldFocusNode;
  final bool isPassword;
  final VoidCallback? onPressVisibilityPassword;

  CustomTextField({
    super.key,
    required this.textController,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.padding,
    this.textFieldFocusNode,
    this.isPassword = false,
    this.onPressVisibilityPassword,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.surface),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextField(
            controller: textController,
            obscureText: obscureText,
            style: theme.textTheme.bodyMedium,
            focusNode: textFieldFocusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
              suffixIcon: isPassword
                    ? GestureDetector(
                        onTap: onPressVisibilityPassword,
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      )
                    : suffixIcon,
              ),
            ),
          ),
        ),
    );
  }
}
