import 'dart:convert';
import 'package:apps_skripsi/core/models/summary_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class SummaryModels {
  Future<SummaryApi?> summary(String idSummary, String token) async {
    final respons = await http.get(
        Uri.parse(
            "http://${Localhost.localhost}:8080/api/v1/summary/${idSummary}"),
        headers: {'Authorization': 'Bearer ${token}'});

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      return SummaryApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
