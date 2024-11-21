import 'package:apps_skripsi/core/models/lesson_api.dart';
import 'package:apps_skripsi/core/service/lesson_models.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class LessonProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  LessonApi? _lessonApi;
  final LessonModels _lessonModels = LessonModels();
  String _idLesson = '';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LessonApi? get lessonApi => _lessonApi;
  String get idLesson => _idLesson;

  void setIDLesson(String id) {
    _idLesson = id;
    notifyListeners();
  }

  Future<void> lessonFetch(String id_courses) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final lessonData = await _lessonModels.lessonAPI(id_courses, token ?? '');
      if (lessonData != null) {
        _lessonApi = lessonData;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void cleanData() {
    _lessonApi = null;
    _errorMessage = null;
    notifyListeners();
  }
}
