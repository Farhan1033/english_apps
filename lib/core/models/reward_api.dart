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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status_code'] = statusCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['points'] = points;
    data['description'] = description;
    data['terms'] = terms;
    return data;
  }
}
