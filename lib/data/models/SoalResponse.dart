import 'Soal.dart';

class SoalResponse {
  final int currentPage;
  final List<Soal> data;
  final int total;

  SoalResponse({
    required this.currentPage,
    required this.data,
    required this.total,
  });

  factory SoalResponse.fromJson(Map<String, dynamic> json) {
    return SoalResponse(
      currentPage: json['current_page'],
      data: (json['data'] as List).map((item) => Soal.fromJson(item)).toList(),
      total: json['total'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }
}
