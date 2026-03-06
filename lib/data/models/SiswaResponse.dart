import 'Siswa.dart';

class SiswaResponse {
  final String message;
  final List<Siswa> data;

  SiswaResponse({
    required this.message,
    required this.data,
  });

  factory SiswaResponse.fromJson(Map<String, dynamic> json) {
    return SiswaResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => Siswa.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((siswa) => siswa.toJson()).toList(),
    };
  }
}
