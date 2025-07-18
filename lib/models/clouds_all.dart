class CloudsAll {
  final num? cloudsAll;

  CloudsAll({this.cloudsAll});

  Map<String, dynamic> toJson() {
    return {
      'all': cloudsAll,
    };
  }

  factory CloudsAll.fromJson(Map<String, dynamic> json) {
    final cloudsAll = (json['all'] as num?)?.toInt();
    return CloudsAll(cloudsAll: cloudsAll);
  }
}
