import 'package:flutter/material.dart';
import 'package:weather/models/weather_response.dart';
import 'package:weather/service/weather_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    fetchWeather();
  }

  final cityTextController = TextEditingController().obs;
  final weatherService = WeatherService().obs;
  final weatherResponse = WeatherResponse().obs;

  Future<String?> fetchWeather() async {
    try {
      String? cityName = await weatherService.value.getCurrentCity();

      final response = await weatherService.value.getWeather(cityName!);

      weatherResponse.value = response;
    } catch (error) {
      debugPrint('error: $error');
    }
    return null;
  }

  void search() async {
    try {
      final response =
          await weatherService.value.getWeather(cityTextController.value.text);
      weatherResponse.value = response;
    } catch (error) {
      debugPrint('error: $error');
    }
  }
}
