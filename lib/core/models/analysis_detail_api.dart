class AnalysisDetailApi {
  String? message;
  int? statusCode;
  List<Data>? data;

  AnalysisDetailApi({this.message, this.statusCode, this.data});

  AnalysisDetailApi.fromJson(Map<String, dynamic> json) {
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
  String? course;
  String? description;
  List<Progress>? progress;

  Data({this.course, this.description, this.progress});

  Data.fromJson(Map<String, dynamic> json) {
    course = json['course'];
    description = json['description'];
    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(Progress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course'] = course;
    data['description'] = description;
    if (progress != null) {
      data['progress'] = progress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Progress {
  String? category;
  int? progressPercentage;

  Progress({this.category, this.progressPercentage});

  Progress.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    progressPercentage = json['progress_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['progress_percentage'] = progressPercentage;
    return data;
  }
}
