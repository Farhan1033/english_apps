class ProgressApi {
  String? status;
  int? progressPercentage;
  String? lesson;

  ProgressApi({this.status, this.progressPercentage, this.lesson});

  ProgressApi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    progressPercentage = json['progress_percentage'];
    lesson = json['lesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['progress_percentage'] = progressPercentage;
    data['lesson'] = lesson;
    return data;
  }
}