class VideoApi {
  String? id;
  String? title;
  String? description;
  String? url;
  int? videoExp;
  int? videoPoin;
  String? createdAt;
  String? updatedAt;

  VideoApi(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.videoExp,
      this.videoPoin,
      this.createdAt,
      this.updatedAt});

  VideoApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    videoExp = json['video_exp'];
    videoPoin = json['video_poin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['video_exp'] = this.videoExp;
    data['video_poin'] = this.videoPoin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}