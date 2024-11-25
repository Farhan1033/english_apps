class SummaryApi {
  String? id;
  String? description;
  String? url;
  String? lessonId;
  String? createdAt;
  String? updatedAt;

  SummaryApi(
      {this.id,
      this.description,
      this.url,
      this.lessonId,
      this.createdAt,
      this.updatedAt});

  SummaryApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    url = json['url'];
    lessonId = json['lesson_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['url'] = url;
    data['lesson_id'] = lessonId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
