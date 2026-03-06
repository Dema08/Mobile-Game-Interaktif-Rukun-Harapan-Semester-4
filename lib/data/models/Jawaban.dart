class Jawaban {
  final String text;
  final bool isBenar;

  Jawaban({required this.text, required this.isBenar});

  factory Jawaban.fromJson(Map<String, dynamic> json) {
    return Jawaban(
      text: json['text'],
      isBenar: json['is_benar'] ?? false,
    );
  }
}
