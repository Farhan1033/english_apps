import 'dart:convert';

import 'package:apps_skripsi/core/models/talk_ai_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class TalkAiModels {
  Future<TalkAiApi?> talkAiModels(String token, String sentence) async {
    final response = await http.post(
        Uri.parse('http://${Localhost.localhost}/chatAI'),
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode({'sentence': sentence}));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(response.body);
      return TalkAiApi.fromJson(jsonData);
    } else {
      print(response.body);
      return null;
    }
  }
}
