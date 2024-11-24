import 'dart:convert';

import 'package:apps_skripsi/core/models/analysis_detail_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class AnalysisDetailModels {
  Future<AnalysisDetailApi?> analysisDetailModels(String token) async {
    final response = await http.get(
        Uri.parse('http://${Localhost.localhost}/courses/summary'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return AnalysisDetailApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
