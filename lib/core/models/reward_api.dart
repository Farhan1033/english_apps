class RewardApi {
  String? message;
  int? statusCode;
  List<Data>? data;

  RewardApi({this.message, this.statusCode, this.data});

  RewardApi.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  int? points;
  String? description;
  String? terms;

  Data({this.id, this.name, this.points, this.description, this.terms});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    points = json['points'];
    description = json['description'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['points'] = this.points;
    data['description'] = this.description;
    data['terms'] = this.terms;
    return data;
  }
}
