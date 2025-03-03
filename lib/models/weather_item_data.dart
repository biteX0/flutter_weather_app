import 'package:weather/models/weather_response.dart';

class WeatherItemData {
  final String icon;
  final String prefix;
  final String suffix;
  final String Function(WeatherResponse) getValue;

  WeatherItemData({
    required this.icon,
    required this.prefix,
    required this.suffix,
    required this.getValue,
  });

  String getText(WeatherResponse response) {
    return "$prefix ${getValue(response)} $suffix";
  }
}

final weatherItems = [
  WeatherItemData(
    icon: 'assets/icons/wind.png',
    prefix: "Скорость ветра",
    suffix: "м/с",
    getValue: (response) => response.wind?.speed?.toString() ?? '',
  ),
  WeatherItemData(
    icon: 'assets/icons/feelslike.png',
    prefix: "Ощущается как",
    suffix: "°",
    getValue: (response) => response.mainInfoValue?.feelsLike?.toString() ?? '',
  ),
  WeatherItemData(
    icon: 'assets/icons/pressure.png',
    prefix: "Давление",
    suffix: "мм рт.ст.",
    getValue: (response) => response.mainInfoValue?.pressure?.toString() ?? '',
  ),
  WeatherItemData(
    icon: 'assets/icons/clouds.png',
    prefix: "Вероятность осадков",
    suffix: "%",
    getValue: (response) => response.clouds?.cloudsAll?.toString() ?? '',
  ),
  WeatherItemData(
    icon: 'assets/icons/humidity.png',
    prefix: "Влажность",
    suffix: "%",
    getValue: (response) => response.mainInfoValue?.humidity?.toString() ?? '',
  ),
  WeatherItemData(
    icon: 'assets/icons/visibility.png',
    prefix: "Видимость",
    suffix: "км",
    getValue: (response) => response.visibility?.toString() ?? '',
  ),
];