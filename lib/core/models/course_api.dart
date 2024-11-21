class CourseApi {
  String? coursesName;
  String? description;
  int? progress;
  String? courseId;
  List<ListLessons>? listLessons;

  CourseApi(
      {this.coursesName,
      this.description,
      this.progress,
      this.courseId,
      this.listLessons});

  CourseApi.fromJson(Map<String, dynamic> json) {
    coursesName = json['courses_name'];
    description = json['description'];
    progress = json['progress'];
    courseId = json['course_id'];
    if (json['list_lessons'] != null) {
      listLessons = <ListLessons>[];
      json['list_lessons'].forEach((v) {
        listLessons!.add(new ListLessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses_name'] = this.coursesName;
    data['description'] = this.description;
    data['progress'] = this.progress;
    data['course_id'] = this.courseId;
    if (this.listLessons != null) {
      data['list_lessons'] = this.listLessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListLessons {
  String? idLesson;
  String? lessonsName;
  String? description;
  int? progress;

  ListLessons(
      {this.idLesson, this.lessonsName, this.description, this.progress});

  ListLessons.fromJson(Map<String, dynamic> json) {
    idLesson = json['id_lesson'];
    lessonsName = json['lessons_name'];
    description = json['description'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lesson'] = this.idLesson;
    data['lessons_name'] = this.lessonsName;
    data['description'] = this.description;
    data['progress'] = this.progress;
    return data;
  }
}