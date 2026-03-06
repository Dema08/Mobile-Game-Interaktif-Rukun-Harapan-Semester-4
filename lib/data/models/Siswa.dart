class Siswa {
  final int id;
  final String username;
  final String? fullName;
  final String nis;
  final int point;
  final String level;
  final String levelLabel;
  final int kelasId;
  final String? namaKelas;
  final String ranking;
  final int harimasuk;

  Siswa({
    required this.id,
    required this.username,
    required this.fullName,
    required this.nis,
    this.point = 0,
    this.level = '',
    this.levelLabel = '',
    this.kelasId = 0,
    required this.namaKelas,
    required this.ranking,
    required this.harimasuk,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      nis: json['nis'] ?? '',
      point: json['point'] ?? 0,
      level: json['level'] ?? '',
      levelLabel: json['level_label'] ?? '',
      kelasId: json['id_kelas'] ?? 0,
      namaKelas: json['nama_kelas'] ?? '',
      ranking: json['ranking'] ?? '-',
      harimasuk: json['harimasuk'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'nis': nis,
      'point': point,
      'level': level,
      'level_label': levelLabel,
      'id_kelas': kelasId,
      'nama_kelas': namaKelas,
      'ranking': ranking,
      'harimasuk': harimasuk,
    };
  }
}
