import 'package:apps_skripsi/core/models/login_api.dart';
import 'package:flutter/foundation.dart';

class LoginState extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  LoginApi? _loginData;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  LoginApi? get loginData => _loginData;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void setLoginData(LoginApi data) {
    _loginData = data;
    notifyListeners();
  }

  void clear() {
    _isLoading = false;
    _hasError = false;
    _loginData = null;
    notifyListeners();
  }
}
