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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['lesson_id'] = lessonId;
    data['course_id'] = courseId;
    data['event_type'] = eventType;
    return data;
  }
}
