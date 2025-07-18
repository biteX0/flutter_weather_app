import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/weather_item_data.dart';
import 'package:weather/theme/theme_service.dart';
import 'package:weather/widgets/background_widget.dart';
import 'package:weather/screens/home/home_controller.dart';
import 'package:weather/widgets/custom_search_field.dart';
import 'package:weather/widgets/progress_indicator.dart';
import 'package:weather/widgets/weather_animation_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/widgets/weather_tile.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  ThemeService get themeService => Get.find<ThemeService>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String date = DateFormat("yMMMd").format(DateTime.now());
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final currentScope = FocusScope.of(context);

        if (!currentScope.hasPrimaryFocus) {
          currentScope.unfocus(); // только если есть фокус
        }
        controller.hideSearchField();
      },
      child: Stack(
        children: [
          const BackgroundWidget(),
          RefreshIndicator(
            onRefresh: () => controller.fetchWeather(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Obx(
                  () => CustomSearchField(
                    showInput: controller.showInput,
                    textController: controller.cityTextController.value,
                    onPressIconSearch: () => controller.toggleSearchInput(),
                    onSearch: () => controller.search(),
                    onPressSwitchTheme: themeService.toggleTheme,
                    onPressLogout: () {
                      FirebaseAuth.instance.signOut();
                    },
                    hintText: 'Введите название города',
                    iconSearch: const Icon(Icons.search),
                    iconSwitchTheme: Icon(theme.brightness == Brightness.dark
                        ? Icons.light_mode
                        : Icons.dark_mode),
                    iconLogout: const Icon(Icons.exit_to_app_rounded),
                    title: controller.user.value?.email ??
                        'Пользователь не авторизован',
                  ),
                ),
              ),
              body: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                scrollDirection: Axis.vertical,
                children: [
                  Center(
                    child: Obx(
                      () {
                        // Пока данные загружаются - выводим индикатор о загрузке
                        if (!controller.isDataComplete) {
                          return const CustomProgressIndicator();
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  controller.weatherResponse.value.cityName!,
                                  style: theme.textTheme.headlineLarge,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                date,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                children: [
                                  Lottie.asset(
                                      WeatherAnimationUtils.getWeatherAnimation(
                                          controller.weatherResponse.value
                                              .weatherDescriptionInfo?.main)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      controller.weatherResponse.value
                                          .weatherDescriptionInfo!.description!
                                          .toUpperCase(),
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                  Text(
                                    "${controller.weatherResponse.value.mainInfoValue?.temperature?.toInt()}°",
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 17,
                              mainAxisSpacing: 15,
                              children: List.generate(
                                weatherItems.length,
                                (index) {
                                  final item = weatherItems[index];
                                  final value = double.tryParse(item.getValue(
                                          controller.weatherResponse.value)) ??
                                      0;
                                  return WeatherTile(
                                    icon: item.icon,
                                    value: value,
                                    prefix: item.prefix,
                                    suffix: item.suffix,
                                    showIndicator: item.prefix == "Влажность" ||
                                        item.prefix == "Осадки",
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
