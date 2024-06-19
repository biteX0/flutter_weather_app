class CloudsAll {
  final num? cloudsAll;

  CloudsAll({required this.cloudsAll});

  factory CloudsAll.fromJson(Map<String, dynamic> json) {
    final cloudsAll = (json['all'] as num?)?.toInt();
    return CloudsAll(cloudsAll: cloudsAll);
  }
}
