class DashboardModel {
  final int userId;
  final String fullName;
  final int point;
  final String ranking;

  DashboardModel({
    required this.userId,
    required this.fullName,
    required this.point,
    required this.ranking,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      userId: json['user_id'],
      fullName: json['full_name'],
      point: json['point'],
      ranking: json['ranking'],
    );
  }
}
