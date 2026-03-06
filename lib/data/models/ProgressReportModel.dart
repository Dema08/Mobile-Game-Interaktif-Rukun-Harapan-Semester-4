class ProgressReportModel {
  final int totalQuizzesPlayed;
  final int quizzesWon;
  final String totalPoints;
  final String? topCategory;
  final int activeDaysThisMonth;

  ProgressReportModel({
    required this.totalQuizzesPlayed,
    required this.quizzesWon,
    required this.totalPoints,
    this.topCategory,
    required this.activeDaysThisMonth,
  });

  factory ProgressReportModel.fromJson(Map<String, dynamic> json) {
    return ProgressReportModel(
      totalQuizzesPlayed: json['total_quizzes_played'] ?? 0,
      quizzesWon: json['quizzes_won'] ?? 0,
      totalPoints: json['total_points'] ?? '0',
      topCategory: json['top_category'] ?? "-",
      activeDaysThisMonth: json['active_days_this_month'] ?? 0,
    );
  }
}
