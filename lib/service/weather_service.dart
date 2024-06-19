import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather/models/weather_response.dart';

class WeatherService {
  Future<WeatherResponse> getWeather(String cityName) async {
    final queryParametrs = {
      'q': cityName,
      'appid': '37279a3be9eb5678a378e453112f694d',
      'units': 'metric',
      'lang': 'ru'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParametrs);
    final weatherResponse = await http.get(uri);

    if (weatherResponse.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(weatherResponse.body));
    } else {
      throw Get.snackbar('Название города не найдено',
          'Ошибка: ${weatherResponse.statusCode}');
    }
  }

  Future<String?> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? cityName = placemarks[0].locality;

    return cityName;
  }
}
