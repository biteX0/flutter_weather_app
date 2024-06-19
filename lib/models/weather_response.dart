import 'package:weather/models/clouds_all.dart';
import 'package:weather/models/main_info_weather.dart';
import 'package:weather/models/weather_description.dart';
import 'package:weather/models/wind.dart';

class WeatherResponse {
  final String? cityName;
  final num? visibility;
  final MainInfoValue? mainInfoValue;
  final WeatherDescriptionInfo? weatherDescriptionInfo;
  final Wind? wind;
  final CloudsAll? clouds;

  WeatherResponse(
      {this.cityName,
      this.visibility,
      this.mainInfoValue,
      this.weatherDescriptionInfo,
      this.wind,
      this.clouds});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final visibility = (json['visibility'] / 1000 as num?)?.toInt();

    final mainInfoValueJson = json['main'];
    final mainInfoValue = MainInfoValue.fromJson(mainInfoValueJson);

    final weatherDescriptionInfoJson = json['weather'][0];
    final weatherDescriptionInfo =
        WeatherDescriptionInfo.fromJson(weatherDescriptionInfoJson);

    final windJson = json['wind'];
    final wind = Wind.fromJson(windJson);

    final cloudsJson = json['clouds'];
    final clouds = CloudsAll.fromJson(cloudsJson);

    return WeatherResponse(
        cityName: cityName,
        mainInfoValue: mainInfoValue,
        weatherDescriptionInfo: weatherDescriptionInfo,
        wind: wind,
        clouds: clouds,
        visibility: visibility);
  }
}
