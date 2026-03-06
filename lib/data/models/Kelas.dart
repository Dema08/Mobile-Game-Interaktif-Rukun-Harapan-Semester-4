class Kelas {
  final int id;
  final String namaKelas;
  final String tahunAjaran;
  final int semester;
  final DateTime createdAt;
  final DateTime updatedAt;

  Kelas({
    required this.id,
    required this.namaKelas,
    required this.tahunAjaran,
    required this.semester,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['id'],
      namaKelas: json['nama_kelas'],
      tahunAjaran: json['tahun_ajaran'],
      semester: json['semester'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kelas': namaKelas,
      'tahun_ajaran': tahunAjaran,
      'semester': semester,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
