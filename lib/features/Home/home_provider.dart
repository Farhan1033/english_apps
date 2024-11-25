import 'package:apps_skripsi/core/models/gamifikasi_api.dart';
import 'package:apps_skripsi/core/models/progress_api.dart';
import 'package:apps_skripsi/core/service/gamifikasi_models.dart';
import 'package:apps_skripsi/core/service/progress_models.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  GamifikasiApi? _gamifikasiApi;
  ProgressApi? _progressApi;
  final GamifikasiModels _gamifikasiModels = GamifikasiModels();
  final ProgressModels _progressModels = ProgressModels();
  String? _userName;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  GamifikasiApi? get gamifikasiApi => _gamifikasiApi;
  ProgressApi? get progressApi => _progressApi;
  String? get userName => _userName;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void setGamifikasiAPI(GamifikasiApi value) {
    _gamifikasiApi = value;
    notifyListeners();
  }

  void setProgressLesson(ProgressApi value) {
    _progressApi = value;
    notifyListeners();
  }

  void setName(String? value) {
    _userName = value;
    notifyListeners();
  }

  Future<void> getUserName() async {
    final userName = await Token().getName();
    setName(userName ?? '');
  }

  Future<void> gamifikasi() async {
    setLoading(true);
    setError(false);
    notifyListeners();

    try {
      final token = await Token().getToken();
      final gamifikasiData =
          await _gamifikasiModels.gamifikasiModel(token ?? 'Token not found');
      if (gamifikasiData != null) {
        setGamifikasiAPI(gamifikasiData);
      }
    } catch (e) {
      setError(true);
    } finally {
      setLoading(false);
      //  notifyListeners();
    }
  }

  Future<void> progressLesson() async {
    setLoading(true);
    setError(false);
    notifyListeners();
    try {
      final token = await Token().getToken();
      final progressLesson =
          await _progressModels.progressModels(token ?? 'Token tidak ada');
      if (progressLesson != null) {
        setProgressLesson(progressLesson);
        //  notifyListeners();
      }
    } catch (e) {
      setError(true);
      // notifyListeners();
    } finally {
      setLoading(false);
      //notifyListeners();
    }
  }

  Future<void> removeToken() async {
    final rmToken = await Token().removeToken();
    return rmToken;
  }

  void clear() {
    _isLoading = false;
    _hasError = false;
    _gamifikasiApi = null;
    _progressApi = null;
    notifyListeners();
  }
}
