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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['url'] = this.url;
    data['lesson_id'] = this.lessonId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
