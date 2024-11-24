import 'dart:convert';
import 'package:apps_skripsi/core/models/register_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class RegisterModel {
  static const String url =
      'http://${Localhost.localhost}/auth/register';

  Future<RegisterApi?> registerAPI(
      String username, String email, String password) async {
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': 'user'
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return RegisterApi?.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
