import 'package:flutter/material.dart';
import 'package:weather/models/weather_response.dart';
import 'package:weather/service/weather_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final cityTextController = TextEditingController().obs;
  final weatherService = WeatherService().obs;
  final weatherResponse = WeatherResponse().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchWeather();
  }

    bool get isDataComplete {
    final data = weatherResponse.value;
    return data.cityName != null &&
           data.weatherDescriptionInfo?.description != null &&
           data.mainInfoValue?.temperature != null &&
           data.wind?.speed != null &&
           data.mainInfoValue?.feelsLike != null &&
           data.mainInfoValue?.pressure != null &&
           data.mainInfoValue?.humidity != null &&
           data.visibility != null;
  }

  Future<String?> fetchWeather() async {
    try {
      isLoading.value = true;
      String? cityName = await weatherService.value.getCurrentCity();

      final response = await weatherService.value.getWeather(cityName!);

      weatherResponse.value = response;
    } catch (error) {
      debugPrint('error: $error');
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  void search() async {
    try {
      isLoading.value = true;
      final response =
          await weatherService.value.getWeather(cityTextController.value.text);
      weatherResponse.value = response;
      cityTextController.value.clear();
    } catch (error) {
      debugPrint('error: $error');
    } finally {
      isLoading.value = false;
    }
  }
}