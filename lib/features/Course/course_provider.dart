import 'package:apps_skripsi/core/service/course_models.dart';
import 'package:flutter/foundation.dart';
import 'package:apps_skripsi/core/models/course_api.dart';

class CourseProvider with ChangeNotifier {
  final CourseService _courseService = CourseService();
  CourseApi? _courses;
  bool _isLoading = false;
  String? _errorMessage;
  final List<String> _categories = ['beginner', 'advanced', 'intermediate'];
  String _categoryCourse = 'beginner';
  String _idCourses = '';

  set categoryCourse(String? newCategory) {
    if (newCategory != null && newCategory != _categoryCourse) {
      _categoryCourse = newCategory;
      notifyListeners();
    }
  }

  String get idCourses => _idCourses;
  CourseApi? get course => _courses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get categories => _categories;
  String get categoryCourse => _categoryCourse;

  void setIdCourses(String id) {
    _idCourses = id;
    notifyListeners();
  }

  Future<void> fetchCourse(String categoryCourses, String tokenCourse) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final fetchedCourse =
          await _courseService.courses(categoryCourses, tokenCourse);
      if (fetchedCourse != null) {
        _courses = fetchedCourse;
      } else {
        _errorMessage = "Course not found.";
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _courses = null;
    _errorMessage = null;
    notifyListeners();
  }
}
