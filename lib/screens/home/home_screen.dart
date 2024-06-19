import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/widgets/background_widget.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/home/home_controller.dart';
import 'package:weather/widgets/whether_row_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  String date = DateFormat("yMMMd").format(DateTime.now());
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: () => controller.fetchWeather(),
        color: CustomColors.refreshIndicatorColor,
        child: Stack(
          children: [
            const BackgroundWidget(),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        user.email!,
                        style: TextStyle(
                          fontSize: 15,
                          color: CustomColors.textColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        size: 30,
                        color: CustomColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              body: Obx(
                () => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 45, right: 45, bottom: 15),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: TextField(
                          controller: controller.cityTextController.value,
                          decoration: InputDecoration(
                            hintText: 'Введите название города',
                            hintStyle:
                                const TextStyle(color: CustomColors.textColor),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                color: CustomColors.textColor,
                                onPressed: () {
                                  controller.search();
                                }),
                          ),
                          style: const TextStyle(color: CustomColors.textColor),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        controller.weatherResponse.value.cityName ??
                            "Загрузка...",
                        style: const TextStyle(
                            fontSize: 30,
                            height: 2,
                            color: CustomColors.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.textColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 20),
                      child: Column(
                        children: [
                          Lottie.asset(getWeatherAnimation(controller
                              .weatherResponse
                              .value
                              .weatherDescriptionInfo
                              ?.main)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              controller.weatherResponse.value
                                      .weatherDescriptionInfo?.description
                                      ?.toUpperCase() ??
                                  "Загрузка...",
                              style: const TextStyle(
                                color: CustomColors.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${controller.weatherResponse.value.mainInfoValue?.temperature?.toInt() ?? "Загрузка..."}°",
                            style: const TextStyle(
                                color: CustomColors.textColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        WeatherRowItem(
                          icon: 'assets/icons/wind.png',
                          text:
                              "Скорость ветра ${controller.weatherResponse.value.wind?.speed ?? "..."} м/с",
                        ),
                        WeatherRowItem(
                          icon: 'assets/icons/feelslike.png',
                          text:
                              "Ощущается как ${controller.weatherResponse.value.mainInfoValue?.feelsLike ?? "..."}°",
                        ),
                        WeatherRowItem(
                          icon: 'assets/icons/pressure.png',
                          text:
                              "Давление ${controller.weatherResponse.value.mainInfoValue?.pressure ?? "..."} мм рт.ст.",
                        ),
                        WeatherRowItem(
                          icon: 'assets/icons/clouds.png',
                          text:
                              "Вероятность осадков ${controller.weatherResponse.value.clouds?.cloudsAll ?? "..."} %",
                        ),
                        WeatherRowItem(
                          icon: 'assets/icons/humidity.png',
                          text:
                              "Влажность ${controller.weatherResponse.value.mainInfoValue?.humidity ?? "..."} %",
                        ),
                        WeatherRowItem(
                          icon: 'assets/icons/visibility.png',
                          text:
                              "Видимость ${controller.weatherResponse.value.visibility ?? "..."} км",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getWeatherAnimation(String? mainCondition) {
    controller.weatherResponse.value.weatherDescriptionInfo?.main =
        mainCondition;
    switch (mainCondition) {
      case 'Thunderstorm':
        return 'assets/lottie/thunderstorm.json';
      case 'Drizzle':
        return 'assets/lottie/Rain_Sun.json';
      case 'Rain':
        return 'assets/lottie/Rain_Sun.json';
      case 'Snow':
        return 'assets/lottie/blizzard.json';
      case 'Mist':
        return 'assets/lottie/mist.json';
      case 'Clear':
        return 'assets/lottie/sunny.json';
      case 'Clouds':
        return 'assets/lottie/cloud.json';
      default:
        return 'assets/lottie/Loading.json';
    }
  }
}
