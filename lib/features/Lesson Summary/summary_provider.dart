import 'package:apps_skripsi/core/models/summary_api.dart';
import 'package:apps_skripsi/core/service/event_lesson_models.dart';
import 'package:apps_skripsi/core/service/summary_models.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:apps_skripsi/features/Lesson/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  SummaryApi? _summaryApi;
  final SummaryModels _summaryModels = SummaryModels();
  final EventLessonModels _eventLessonModels = EventLessonModels();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  SummaryApi? get summaryAPI => _summaryApi;

  Future<void> summaryData(String idSummary) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final summaryDataFetch =
          await _summaryModels.summary(idSummary, token ?? 'Token Not Found!');
      if (summaryDataFetch != null) {
        _summaryApi = summaryDataFetch;
      }
    } catch (e) {
      _errorMessage = e.toString();
      cleanData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> summaryCompleted(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    // notifyListeners();

    try {
      final token = await Token().getToken();
      // ignore: use_build_context_synchronously
      final lesson = Provider.of<LessonProvider>(context, listen: false);
      final idCourse =
          // ignore: use_build_context_synchronously
          Provider.of<CourseProvider>(context, listen: false).idCourses;
      if (lesson.lessonApi!.summary!.isCompleted == false) {
        await _eventLessonModels.eventExcerciseCompleted(
            token ?? '', lesson.idLesson, idCourse, 'summary');
      } else {
        await summaryData(lesson.lessonApi!.summary!.summaryId!);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void cleanData() {
    _errorMessage = null;
    _summaryApi = null;
    notifyListeners();
  }
}
