class Wind {
  final num? speed;

  Wind({this.speed});
  factory Wind.fromJson(Map<String, dynamic> json) {
    final speed = (json['speed'] as num?)?.toInt();
    return Wind(speed: speed);
  }
}
