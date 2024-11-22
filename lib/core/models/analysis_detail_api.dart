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
        progress!.add(new Progress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course'] = this.course;
    data['description'] = this.description;
    if (this.progress != null) {
      data['progress'] = this.progress!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['progress_percentage'] = this.progressPercentage;
    return data;
  }
}
