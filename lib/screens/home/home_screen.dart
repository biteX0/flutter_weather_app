import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/weather_item_data.dart';
import 'package:weather/theme/theme_service.dart';
import 'package:weather/widgets/background_widget.dart';
import 'package:weather/screens/home/home_controller.dart';
import 'package:weather/widgets/progress_indicator.dart';
import 'package:weather/widgets/weather_animation_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/widgets/custom_text_field.dart';
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BackgroundWidget(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user?.email ?? 'Пользователь не авторизован',
                      style: theme.textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(theme.brightness == Brightness.dark
                              ? Icons.light_mode
                              : Icons.dark_mode),
                          onPressed: themeService.toggleTheme,
                        ),
                        IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          icon: const Icon(Icons.exit_to_app_rounded),
                        ),
                      ],
                    ),
                  ],
                )),
            body: RefreshIndicator(
              onRefresh: () => controller.fetchWeather(),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                scrollDirection: Axis.vertical,
                children: [
                  Obx(
                    () {
                      if (!controller.isDataComplete) {
                        return const CustomProgressIndicator();
                      }
                      return Column(
                        children: [
                          CustomTextField(
                            textController: controller.cityTextController.value,
                            padding: EdgeInsets.all(0),
                            hintText: 'Введите название города',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              color: theme.colorScheme.onSurface,
                              onPressed: () => controller.search(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  controller.weatherResponse.value.cityName!,
                                  style: theme.textTheme.headlineMedium),
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
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: weatherItems.length,
                            itemBuilder: (context, index) {
                              final item = weatherItems[index];
                              final value = double.tryParse(
                                      item.getValue(controller.weatherResponse.value)) ?? 0;
                                      
                              
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
                        ],
                      );
                    },
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
