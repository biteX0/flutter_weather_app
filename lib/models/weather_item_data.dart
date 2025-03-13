import 'package:weather/models/weather_response.dart';

class WeatherItemData {
  final String icon;
  final String prefix;
  final String suffix;
  final String Function(WeatherResponse) getValue;
  final bool showIndicator;

  WeatherItemData({
    required this.icon,
    required this.prefix,
    required this.suffix,
    required this.getValue,
    this.showIndicator = false,
  });

  String getText(WeatherResponse response) {
    return "${getValue(response)} $suffix";
  }
}

final weatherItems = [
  WeatherItemData(
    icon: 'assets/icons/wind.png',
    prefix: 'Скорость ветра',
    suffix: ' м/с',
    getValue: (response) => response.wind?.speed?.toString() ?? '0',
  ),
  WeatherItemData(
    icon: 'assets/icons/feelslike.png',
    prefix: 'Ощущается',
    suffix: ' °',
    getValue: (response) => response.mainInfoValue?.feelsLike?.toString() ?? '0',
  ),
  WeatherItemData(
    icon: 'assets/icons/pressure.png',
    prefix: 'Давление',
    suffix: ' мм',
    getValue: (response) => response.mainInfoValue?.pressure?.toString() ?? '0',
  ),
  WeatherItemData(
    icon: 'assets/icons/clouds.png',
    prefix: 'Осадки',
    suffix: ' %',
    getValue: (response) => response.clouds?.cloudsAll?.toString() ?? '0',
    showIndicator: true,
  ),
  WeatherItemData(
    icon: 'assets/icons/humidity.png',
    prefix: 'Влажность',
    suffix: ' %',
    getValue: (response) => response.mainInfoValue?.humidity?.toString() ?? '0',
    showIndicator: true,
  ),
  WeatherItemData(
    icon: 'assets/icons/visibility.png',
    prefix: 'Видимость',
    suffix: ' км',
    getValue: (response) => response.visibility?.toString() ?? '0',
  ),
];