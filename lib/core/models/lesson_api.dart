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
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
    exercise = json['exercise'] != null
        ? Exercise.fromJson(json['exercise'])
        : null;
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    totalProgress = json['total_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lesson_name'] = lessonName;
    if (video != null) {
      data['video'] = video!.toJson();
    }
    if (exercise != null) {
      data['exercise'] = exercise!.toJson();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    data['total_progress'] = totalProgress;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_id'] = videoId;
    data['video_title'] = videoTitle;
    data['video_description'] = videoDescription;
    data['video_url'] = videoUrl;
    data['video_exp'] = videoExp;
    data['video_point'] = videoPoint;
    data['is_completed'] = isCompleted;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exercise_id'] = exerciseId;
    data['exercise_exp'] = exerciseExp;
    data['exercise_point'] = exercisePoint;
    data['is_completed'] = isCompleted;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary_id'] = summaryId;
    data['summary_description'] = summaryDescription;
    data['is_completed'] = isCompleted;
    data['summary_url'] = summaryUrl;
    return data;
  }
}