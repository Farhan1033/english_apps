import 'package:apps_skripsi/core/models/register_api.dart';
import 'package:apps_skripsi/core/service/register_model.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  RegisterApi? _registerApi;
  final RegisterModel _registerModel = RegisterModel();

  bool _keamananConfPass = false;
  bool _keamananPass = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _userName;

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  RegisterApi? get registerApi => _registerApi;
  bool get keamananPass => _keamananPass;
  bool get keamananConfPass => _keamananConfPass;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get userName => _userName;

  void setUserName(String? value) {
    _userName = value;
    notifyListeners();
  }

  void toggleKeamananPass() {
    _keamananPass = !_keamananPass;
    notifyListeners();
  }

  void toggleKeamananConfPass() {
    _keamananConfPass = !_keamananConfPass;
    notifyListeners();
  }

  void moveLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  bool isValidEmail(String email) {
    final emailReg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailReg.hasMatch(email);
  }

  bool isValidPassword(String passLength) {
    return passLength.length >= 6;
  }

  Future<void> register(BuildContext context, String email, String password,
      String username) async {
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email tidak valid. Periksa format email Anda."),
          backgroundColor: Warna.salah,
        ),
      );
      return;
    }

    if (!isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password minimal harus 6 karakter."),
          backgroundColor: Warna.salah,
        ),
      );
      return;
    }

    if (password != confPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak cocok."),
          backgroundColor: Warna.salah,
        ),
      );
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final registerData =
          await _registerModel.registerAPI(username, email, password);
      if (registerData != null) {
        _registerApi = registerData;
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/login');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registrasi berhasil!"),
            backgroundColor: Warna.benar,
          ),
        );
        clearData();
      } else {
        _errorMessage = 'Gagal mendaftarkan akun';
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Warna.salah,
          ),
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: $_errorMessage"),
          backgroundColor: Warna.salah,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _registerApi = null;
    _errorMessage = null;
    namaController.clear();
    emailController.clear();
    passwordController.clear();
    confPasswordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
  }
}
