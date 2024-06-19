class WeatherDescriptionInfo {
  String? description;
  String? main;

  WeatherDescriptionInfo({
    this.description,
    required this.main,
  });

  factory WeatherDescriptionInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final main = json['main'];

    return WeatherDescriptionInfo(description: description, main: main);
  }
}
