class ProfileModel {
  final int userId;
  final String fullName;
  final String kelas;
  final String ranking;
  final int harimasuk;

  ProfileModel({
    required this.userId,
    required this.fullName,
    required this.kelas,
    required this.ranking,
    required this.harimasuk,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'] ?? 0,
      fullName: json['full_name'] ?? 'Nama tidak tersedia',
      kelas: json['kelas'] ?? 'Kelas tidak tersedia',
      ranking: json['ranking'] ?? "-",
      harimasuk: json['harimasuk'] ?? 0,
    );
  }
}
