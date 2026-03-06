class PeringkatModel {
  final int id;
  final String fullName;
  final String   totalPoint;
  final String kelas;
  final String level;

  PeringkatModel({
    required this.id,
    required this.fullName,
    required this.totalPoint,
    required this.kelas,
    required this.level,
  });

  factory PeringkatModel.fromJson(Map<String, dynamic> json) {
    return PeringkatModel(
      id: json['id'],
      fullName: json['full_name'],
      totalPoint: json['total_point'],
      kelas: json['kelas'],
      level: json['level'],
    );
  }
}
