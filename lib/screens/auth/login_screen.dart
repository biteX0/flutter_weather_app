import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/routing/app_routes.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/service/auth_google_service.dart';
import 'package:weather/theme/theme_service.dart';
import 'package:weather/widgets/custom_button.dart';
import 'package:weather/widgets/tile_auth_widget.dart';
import 'package:weather/widgets/custom_text_field.dart';
import 'package:weather/widgets/background_widget.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  ThemeService get themeService => Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Очищаем поля при каждом построении экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearFields();
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BackgroundWidget(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    onPressed: themeService.toggleTheme,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 25),
                        child: Text(
                          'Вход',
                          style: textTheme.titleLarge,
                        ),
                      ),
                      Obx(
                        () => CustomTextField(
                          textController: controller.emailController.value,
                          hintText: 'Адрес эл. почты',
                        ),
                      ),
                      Obx(
                        () => CustomTextField(
                          textController: controller.passwordController.value,
                          hintText: 'Пароль',
                          obscureText: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextButton(
                              onPressed: () =>
                                  Get.toNamed(Routes.resetPassword),
                              child: Text(
                                'Сбросить пароль',
                                style: textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: 'Авторизация',
                        onPressed: controller.singInn,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 50, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Или войти с помощью',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TileAuth(
                              icon: 'assets/icons/google_logo_icon.png',
                              onTapTile: () {
                                AuthGoogleService().singInWithGoogle();
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Нет учетной записи? ',
                            style: textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.registration),
                            child: Text(
                              'Регистрация',
                              style: textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
