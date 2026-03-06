class JawabanModel {
  final bool success;
  final String message;
  final int isJawabanBenar;
  final int bonusPoint;
  final int jumlahPoint;

  JawabanModel({
    required this.success,
    required this.message,
    required this.isJawabanBenar,
    required this.bonusPoint,
    required this.jumlahPoint,
  });

  factory JawabanModel.fromJson(Map<String, dynamic> json) {
    return JawabanModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      isJawabanBenar: json['is_jawaban_benar'] as int,
      bonusPoint: json['bonus_point'] as int,
      jumlahPoint: json['jumlah_point'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'is_jawaban_benar': isJawabanBenar,
      'bonus_point': bonusPoint,
      'jumlah_point': jumlahPoint,
    };
  }
}
