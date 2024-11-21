class EventLesson {
  String? userId;
  String? lessonId;
  String? courseId;
  String? eventType;

  EventLesson({this.userId, this.lessonId, this.courseId, this.eventType});

  EventLesson.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    lessonId = json['lesson_id'];
    courseId = json['course_id'];
    eventType = json['event_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['lesson_id'] = this.lessonId;
    data['course_id'] = this.courseId;
    data['event_type'] = this.eventType;
    return data;
  }
}
