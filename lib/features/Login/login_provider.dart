import 'package:apps_skripsi/core/service/login_models.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:apps_skripsi/features/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  final LoginService _loginService = LoginService();
  final Token _token = Token();

  Future<void> login(
      BuildContext context, String email, String password) async {
    final loginState = Provider.of<LoginState>(context, listen: false);
    loginState.setLoading(true);
    loginState.setError(false);

    final loginData = await _loginService.loginUser(email, password);
    if (loginData != null) {
      loginState.setLoginData(loginData);
      _token.saveToken(loginData.token ?? "Token Tidak Ditemukan");
      Navigator.pushReplacementNamed(
          // ignore: use_build_context_synchronously
          context,
          "/wrapper");
    } else {
      loginState.setError(true);
    }

    loginState.setLoading(false);
  }
}
