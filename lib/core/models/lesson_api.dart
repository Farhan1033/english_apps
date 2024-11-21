class LessonApi {
  String? lessonName;
  Video? video;
  Exercise? exercise;
  Summary? summary;
  int? totalProgress;

  LessonApi(
      {this.lessonName,
      this.video,
      this.exercise,
      this.summary,
      this.totalProgress});

  LessonApi.fromJson(Map<String, dynamic> json) {
    lessonName = json['lesson_name'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
    exercise = json['exercise'] != null
        ? new Exercise.fromJson(json['exercise'])
        : null;
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    totalProgress = json['total_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson_name'] = this.lessonName;
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.exercise != null) {
      data['exercise'] = this.exercise!.toJson();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    data['total_progress'] = this.totalProgress;
    return data;
  }
}

class Video {
  String? videoId;
  String? videoTitle;
  String? videoDescription;
  String? videoUrl;
  int? videoExp;
  int? videoPoint;
  bool? isCompleted;

  Video(
      {this.videoId,
      this.videoTitle,
      this.videoDescription,
      this.videoUrl,
      this.videoExp,
      this.videoPoint,
      this.isCompleted});

  Video.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    videoTitle = json['video_title'];
    videoDescription = json['video_description'];
    videoUrl = json['video_url'];
    videoExp = json['video_exp'];
    videoPoint = json['video_point'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['video_title'] = this.videoTitle;
    data['video_description'] = this.videoDescription;
    data['video_url'] = this.videoUrl;
    data['video_exp'] = this.videoExp;
    data['video_point'] = this.videoPoint;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}

class Exercise {
  String? exerciseId;
  int? exerciseExp;
  int? exercisePoint;
  bool? isCompleted;

  Exercise(
      {this.exerciseId,
      this.exerciseExp,
      this.exercisePoint,
      this.isCompleted});

  Exercise.fromJson(Map<String, dynamic> json) {
    exerciseId = json['exercise_id'];
    exerciseExp = json['exercise_exp'];
    exercisePoint = json['exercise_point'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exercise_id'] = this.exerciseId;
    data['exercise_exp'] = this.exerciseExp;
    data['exercise_point'] = this.exercisePoint;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}

class Summary {
  String? summaryId;
  String? summaryDescription;
  bool? isCompleted;
  String? summaryUrl;

  Summary(
      {this.summaryId,
      this.summaryDescription,
      this.isCompleted,
      this.summaryUrl});

  Summary.fromJson(Map<String, dynamic> json) {
    summaryId = json['summary_id'];
    summaryDescription = json['summary_description'];
    isCompleted = json['is_completed'];
    summaryUrl = json['summary_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary_id'] = this.summaryId;
    data['summary_description'] = this.summaryDescription;
    data['is_completed'] = this.isCompleted;
    data['summary_url'] = this.summaryUrl;
    return data;
  }
}