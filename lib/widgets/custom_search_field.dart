import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/theme/theme_service.dart';
import 'package:weather/widgets/custom_text_field.dart';

class CustomSearchField extends StatelessWidget {
  final RxBool showInput;
  final TextEditingController textController;
  final VoidCallback onPressIconSearch;
  final VoidCallback onSearch;
  final VoidCallback onPressLogout;
  final VoidCallback onPressSwitchTheme;
  final String hintText;
  final Icon iconSearch;
  final Icon iconSwitchTheme;
  final Icon iconLogout;
  final String title;

  CustomSearchField({
    super.key,
    required this.showInput,
    required this.textController,
    required this.onPressIconSearch,
    required this.onSearch,
    required this.onPressSwitchTheme,
    required this.onPressLogout,
    required this.hintText,
    required this.iconSearch,
    required this.iconSwitchTheme,
    required this.iconLogout,
    required this.title,
  });

  ThemeService get themeService => Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => showInput.value
          ? CustomTextField(
              textController: textController,
              padding: EdgeInsets.zero,
              hintText: hintText,
              suffixIcon: IconButton(
                icon: iconSearch,
                color: theme.colorScheme.onSurface,
                onPressed: () => onSearch(),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: iconSearch,
                      color: theme.colorScheme.onSurface,
                      onPressed: () => onPressIconSearch(),
                    ),
                    IconButton(
                      icon: iconSwitchTheme,
                      onPressed: themeService.toggleTheme,
                    ),
                    IconButton(
                      onPressed: () => onPressLogout(),
                      icon: iconLogout,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
