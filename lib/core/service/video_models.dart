import 'dart:convert';

import 'package:apps_skripsi/core/models/video_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class VideoModels {
  Future<VideoApi?> video(String idVideo, String token) async{
    final response = await http.get(Uri.parse('http://${Localhost.localhost}/video-parts/$idVideo'),
    headers: {'Authorization' : 'Bearer $token'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return VideoApi.fromJson(jsonData['data']);
    }else{
      return null;
    }
  }
}