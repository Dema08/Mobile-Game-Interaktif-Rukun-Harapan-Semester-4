class MagicCardUjian {
  final int id;
  final int guruId;
  final int kelasId;
  final int mapelId;
  final String judul;
  final String tipeUjian;
  final DateTime waktuMulai;
  final DateTime waktuSelesai;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool status_pengerjaan;

  MagicCardUjian({
    required this.id,
    required this.guruId,
    required this.kelasId,
    required this.mapelId,
    required this.judul,
    required this.tipeUjian,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.createdAt,
    required this.updatedAt,
    required this.status_pengerjaan,
  });

  factory MagicCardUjian.fromJson(Map<String, dynamic> json) {
    return MagicCardUjian(
      id: json['id'] as int,
      guruId: json['guru_id'] as int,
      kelasId: json['kelas_id'] as int,
      mapelId: json['mapel_id'] as int,
      judul: json['judul'] as String,
      tipeUjian: json['tipe_ujian'] as String,
      waktuMulai: DateTime.parse(json['waktu_mulai']),
      waktuSelesai: DateTime.parse(json['waktu_selesai']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status_pengerjaan: json['status_pengerjaan'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guru_id': guruId,
      'kelas_id': kelasId,
      'mapel_id': mapelId,
      'judul': judul,
      'tipe_ujian': tipeUjian,
      'waktu_mulai': waktuMulai.toIso8601String(),
      'waktu_selesai': waktuSelesai.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status_pengerjaan': status_pengerjaan,
    };
  }
}
