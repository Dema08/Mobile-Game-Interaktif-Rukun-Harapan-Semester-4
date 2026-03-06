class Soal {
  final int id;
  final String pertanyaan;
  final String tipe;
  final String jawabanBenar;
  final String? gambar;
  final Map<String, String> opsi;

  Soal({
    required this.id,
    required this.pertanyaan,
    required this.tipe,
    required this.jawabanBenar,
    this.gambar,
    required this.opsi,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
      id: json['id'],
      pertanyaan: json['pertanyaan'],
      tipe: json['tipe'],
      jawabanBenar: json['jawaban_benar'],
      gambar: json['gambar'],
      opsi: Map<String, String>.from(json['opsi']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pertanyaan': pertanyaan,
      'tipe': tipe,
      'jawaban_benar': jawabanBenar,
      'gambar': gambar,
      'opsi': opsi,
    };
  }
}
