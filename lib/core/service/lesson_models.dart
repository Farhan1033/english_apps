import 'dart:convert';
import 'package:apps_skripsi/core/models/lesson_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class LessonModels {
  Future<LessonApi?> lessonAPI(String id_courses, String token) async {
    final response = await http.get(
        Uri.parse('http://${Localhost.localhost}:8080/api/v1/lesson/$id_courses'),
        headers: {'Authorization': 'Bearer ${token}'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return LessonApi.fromJson(jsonData['data']);
    } else {
         print(response.body);
      return null;
    }
  }
}
