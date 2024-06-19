class MainInfoValue {
  final num? temperature;
  final num? feelsLike;
  final num? pressure;
  final num? humidity;

  MainInfoValue(
      {required this.temperature,
      required this.feelsLike,
      required this.pressure,
      required this.humidity});

  factory MainInfoValue.fromJson(Map<String, dynamic> json) {
    final temperature = (json['temp'] as num?)?.toInt();
    final feelsLike = (json['feels_like'] as num?)?.toInt();
    final pressure = (json['pressure'] * 0.75 as num?)?.toInt();
    final humidity = (json['humidity'] as num?)?.toInt();

    return MainInfoValue(
        temperature: temperature,
        feelsLike: feelsLike,
        pressure: pressure,
        humidity: humidity);
  }
}
