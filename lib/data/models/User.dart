class User {
  int? id;
  String? username;
  String? fullName;
  String? nis;
  int? point;
  String? level;
  String? levelLabel;

  User({
    this.id,
    this.username,
    this.fullName,
    this.nis,
    this.point,
    this.level,
    this.levelLabel,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    nis = json['nis'];
    point = json['point'];
    level = json['level'];
    levelLabel = json['level_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['full_name'] = fullName;
    data['nis'] = nis;
    data['point'] = point;
    data['level'] = level;
    data['level_label'] = levelLabel;
    return data;
  }
}
