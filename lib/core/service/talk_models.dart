import 'dart:convert';

import 'package:apps_skripsi/core/models/talk_api.dart';
import 'package:http/http.dart' as http;

class TalkModels {
  Future<TalkApi?> talkModels(String sentences) async {
    final response = await http.post(
        Uri.parse('https://adenht-cek-grammar.hf.space/check-grammar'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'sentence': sentences}));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return TalkApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
