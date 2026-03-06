class JawabanSiswaModel {
  final String ujianId;
  final String soalId;
  final String jawaban;
  final String waktuSubmit;

  JawabanSiswaModel({
    required this.ujianId,
    required this.soalId,
    required this.jawaban,
    required this.waktuSubmit,
  });

  Map<String, dynamic> toJson() {
    return {
      'ujian_id': ujianId,
      'soal_id': soalId,
      'jawaban': jawaban,
      'waktu_submit': waktuSubmit,
    };
  }
}
