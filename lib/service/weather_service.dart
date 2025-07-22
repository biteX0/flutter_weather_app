import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/errors/exceptions.dart';
import 'package:weather/service/weather_response.dart';

class WeatherService {
  Future<WeatherResponse> getWeather(String cityName) async {
    final queryParametrs = {
      'q': cityName,
      'appid': 'YOUR_KEY',
      'units': 'metric',
      'lang': 'ru'
    };
    try {
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParametrs);
      final weatherResponse = await http.get(uri).timeout(Duration(seconds: 5));
      if (weatherResponse.statusCode == 200) {
        return WeatherResponse.fromJson(jsonDecode(weatherResponse.body));
      } else if (weatherResponse.statusCode == 404) {
        throw CityNotFoundException();
      } else if (weatherResponse.statusCode >= 500) {
        throw WeatherApiException(weatherResponse.statusCode);
      } else {
        throw Exception('Неизвестная ошибка');
      }
    } on SocketException catch (_) {
      throw NetworkException();
    }
  }

  Future<String?> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException();
    }
    try {
      final position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.best));

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isEmpty) {
        throw CityNotFoundException();
      }
      String? cityName;

      for (var place in placemarks) {
        if (place.locality != null && place.locality!.isNotEmpty) {
          cityName = place.locality;
          break;
        }
      }
      if (cityName == null) {
        throw CityNotFoundException();
      }
      return cityName;
    } on LocationServiceDisabledException catch (_) {
      throw LocationServiceDisabled();
    }
  }
}
