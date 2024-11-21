import 'dart:convert';
import 'package:apps_skripsi/core/models/login_api.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const String _url =
      "http://${Localhost.localhost}:8080/api/v1/auth/login";

  Future<LoginApi?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return LoginApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
