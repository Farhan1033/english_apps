class GamifikasiApi {
  int? level;
  int? currentExp;
  int? nextLevelExp;
  int? totalPoints;

  GamifikasiApi(
      {this.level, this.currentExp, this.nextLevelExp, this.totalPoints});

  GamifikasiApi.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    currentExp = json['current_exp'];
    nextLevelExp = json['next_level_exp'];
    totalPoints = json['total_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['current_exp'] = this.currentExp;
    data['next_level_exp'] = this.nextLevelExp;
    data['total_points'] = this.totalPoints;
    return data;
  }
}
