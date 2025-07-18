import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/errors/exceptions.dart';
import 'package:weather/service/weather_response.dart';
import 'package:weather/service/weather_service.dart';
import 'package:get/get.dart';
import 'package:weather/snackbar_error_messages/barrel_file_snackbar.dart';

class HomeController extends GetxController {
  final cityTextController = TextEditingController().obs;
  final weatherService = WeatherService().obs;
  final weatherResponse = WeatherResponse().obs;
  final isLoading = false.obs;
  final showInput = false.obs;
  final Rxn<User> user = Rxn<User>();
  final dynamicSearchFocusNode = FocusNode();

  // Ключ для сохранения города в SharedPreferences
  static const String _lastCityKey = 'last_city';
  final _prefs = SharedPreferences.getInstance();

  @override
  void onInit() async {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      user.value = firebaseUser;
    });
    await _initWeather();
  }

  // Очистка ресурсов при закрытии
  @override
  void onClose() {
    cityTextController.value.dispose();
    dynamicSearchFocusNode.dispose();
    super.onClose();
  }

  // Проверка наличия всех необходимых данных о погоде
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

  // Инициализация погоды: загрузка сохраненного города или получение текущего
  Future<void> _initWeather() async {
    isLoading.value = true;
    try {
      final prefs = await _prefs;
      final lastCity = prefs.getString(_lastCityKey);
      if (lastCity?.isNotEmpty ?? false) {
        await _loadWeatherForCity(lastCity!);
      } else {
        await fetchWeather();
      }
    } on CityNotFoundException catch (_) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.notFoundCity),
      );
      await fetchWeather();
    } finally {
      isLoading.value = false;
    }
  }

  // Загрузка погоды для конкретного города
  Future<void> _loadWeatherForCity(String city) async {
    isLoading.value = true;
    try {
      final response = await weatherService.value.getWeather(city);
      weatherResponse.value = response;
      cityTextController.value.text = city;
    } on CityNotFoundException {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.notFoundCity),
      );
    } on NetworkException {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.ethernetConnectionNotFound),
      );
    } on TimeoutException {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.serverIsNotResponding),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Получение погоды для текущего местоположения
  Future<void> fetchWeather() async {
    try {
      isLoading.value = true;
      final cityName = await weatherService.value.getCurrentCity();
      if (cityName != null) {
        await _loadWeatherForCity(cityName);
        await _saveCity(cityName);
      }
    } on CityNotFoundException catch (_) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.notFoundCity),
      );
    } on LocationPermissionDeniedException catch (_) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.locationPermissionDenied),
      );
    } on LocationServiceDisabled catch (_) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.locationPermissionDenied),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Поиск погоды по введенному городу
  Future<void> search() async {
    final cityName = cityTextController.value.text.trim();
    cityTextController.value.clear();
    if (cityName.isEmpty) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.enterCityName),
      );
      return;
    }
    isLoading.value = true;
    try {
      // Загружаем погоду для введенного города
      await _loadWeatherForCity(cityName);
      await _saveCity(cityName);
      cityTextController.value.clear();
      showInput.value = false;
    } on CityNotFoundException catch (_) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.notFoundCity),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Сохранение города в SharedPreferences
  Future<void> _saveCity(String city) async {
    if (city.isNotEmpty) {
      final prefs = await _prefs;
      await prefs.setString(_lastCityKey, city);
    }
  }

  // Очистка сохраненного города
  Future<void> clearSavedCity() async {
    final prefs = await _prefs;
    await prefs.remove(_lastCityKey);
    // Очищаем поле ввода
    cityTextController.value.clear();
    await fetchWeather();
  }

  // Видимость поля ввода
  void toggleSearchInput() {
    showInput.value = !showInput.value;
  }

//Скрыть TextField при нажатии на кнопку
  void hideSearchField() {
    if (!dynamicSearchFocusNode.hasFocus) {
      showInput.value = false;
    }
  }
}
