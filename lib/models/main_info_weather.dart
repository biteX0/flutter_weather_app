class MainInfoValue {
  final num? temperature;
  final num? feelsLike;
  final num? pressure;
  final num? humidity;

  MainInfoValue(
      {this.temperature,
      this.feelsLike,
      this.pressure,
      this.humidity});

  Map<String, dynamic> toJson() {
    return {
      'temp': temperature,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
    };
  }

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
