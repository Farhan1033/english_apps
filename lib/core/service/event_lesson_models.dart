import 'dart:convert';
import 'package:apps_skripsi/core/models/event_lesson.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class EventLessonModels {
  Future<EventLesson?> eventExcerciseCompleted(
      String token, String idLesson, String idCourse, String eventType) async {
    final respons = await http.put(
        Uri.parse(
            'http://${Localhost.localhost}:8080/api/v1/update_progress_lesson'),
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode({
          'lesson_id': idLesson,
          'course_id': idCourse,
          'event_type': eventType
        }));

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      return EventLesson.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
