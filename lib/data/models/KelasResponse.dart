import 'Kelas.dart';

class KelasResponse {
  final String message;
  final List<Kelas> data;

  KelasResponse({
    required this.message,
    required this.data,
  });

  factory KelasResponse.fromJson(Map<String, dynamic> json) {
    return KelasResponse(
      message: json['message'],
      data: (json['data'] as List).map((item) => Kelas.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((kelas) => kelas.toJson()).toList(),
    };
  }
}
