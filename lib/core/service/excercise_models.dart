import 'dart:convert';
import 'package:apps_skripsi/core/models/excercise_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class ExcerciseModels {
  Future<ExcerciseApi?> excercise(String idExcercise, String token) async {
    final response = await http.get(
      Uri.parse("http://${Localhost.localhost}:8080/api/v1/exercise-parts/$idExcercise"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ExcerciseApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
