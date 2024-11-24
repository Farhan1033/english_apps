import 'package:apps_skripsi/core/models/excercise_api.dart';
import 'package:apps_skripsi/core/service/event_lesson_models.dart';
import 'package:apps_skripsi/core/service/excercise_models.dart';
import 'package:flutter/material.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';

class ExerciseProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  ExcerciseApi? _exerciseApi;
  final ExcerciseModels _exerciseModels = ExcerciseModels();
  bool _isAnswerSelected = false;
  int _currentIndex = 0;
  int _selectedAnswerIndex = -1;
  int _gradeExercise = 0;
  double? _totalGrade;
  final EventLessonModels _eventLessonModels = EventLessonModels();
  int _exercisePoints = 0;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ExcerciseApi? get exerciseApi => _exerciseApi;
  bool get isAnswerSelected => _isAnswerSelected;
  int get currentIndex => _currentIndex;
  int get selectedAnswerIndex => _selectedAnswerIndex;
  int get gradeExercise => _gradeExercise;
  double? get totalGrade => _totalGrade;
  int get exercisePoints => _exercisePoints;

  String get statusKelulusan {
    if (_exerciseApi == null) {
      return 'Belum ada nilai';
    }

    _totalGrade = (_gradeExercise / _exerciseApi!.quiz!.length) * 100;
    return _totalGrade! >= 75 ? 'Lulus' : 'Tidak Lulus';
  }

  void checkAndSetAnswer(int index, BuildContext context) {
    _selectedAnswerIndex = index;
    _isAnswerSelected = true;

    final isCorrect = _exerciseApi!.quiz![_currentIndex].correctAnswer == index;

    if (isCorrect) {
      _gradeExercise += 1;
      _showSnackBar(context, 'Jawaban Benar!', Warna.benar);
    } else {
      _exercisePoints = (_exerciseApi!.exercisePoin!) - 1;
      if (_exercisePoints < 0) {
        _exercisePoints = 0;
      }
      _showSnackBar(context, 'Jawaban Salah. Coba Lagi!', Warna.salah);
    }
    notifyListeners();
  }

  void nextQuiz() {
    if (_currentIndex + 1 < _exerciseApi!.quiz!.length) {
      _selectedAnswerIndex = -1;
      _isAnswerSelected = false;
      _currentIndex++;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _selectedAnswerIndex = -1;
    _isAnswerSelected = false;
    _currentIndex = 0;
    _exercisePoints = _exerciseApi!.exercisePoin!;
    _gradeExercise = 0;
    notifyListeners();
  }

  Future<void> loadExercise(String exerciseId) async {
    _setLoadingState(true);
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final exerciseData =
          await _exerciseModels.excercise(exerciseId, token ?? '');
      if (exerciseData != null) {
        _exerciseApi = exerciseData;
        _exercisePoints = _exerciseApi!.exercisePoin!;
      } else {
        _errorMessage = 'Data exercise tidak ditemukan.';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      cleanData();
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> completeExercise(String courseId, String lessonId) async {
    _setLoadingState(true);
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      await _eventLessonModels.eventExcerciseCompleted(
          token ?? 'Token Not Found', lessonId, courseId, 'exercise');
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoadingState(false);
    }
  }

  void cleanData() {
    _errorMessage = null;
    _exerciseApi = null;
    notifyListeners();
  }

  void _setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
