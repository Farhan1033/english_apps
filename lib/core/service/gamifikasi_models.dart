import 'dart:convert';

import 'package:apps_skripsi/core/models/gamifikasi_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class GamifikasiModels {
  Future<GamifikasiApi?> gamifikasiModel(String token) async {
    final respons = await http.get(
        Uri.parse('http://${Localhost.localhost}/gamification'),
        headers: {'Authorization': 'Bearer $token'});

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      return GamifikasiApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
