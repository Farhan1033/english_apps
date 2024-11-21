import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:apps_skripsi/features/Course/course_page.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:apps_skripsi/features/Daily-Event/daily_page.dart';
import 'package:apps_skripsi/features/Home/home_page.dart';
import 'package:apps_skripsi/features/Home/home_provider.dart';
import 'package:apps_skripsi/features/Lesson%20Exercise/excercise_detail.dart';
import 'package:apps_skripsi/features/Lesson%20Exercise/excercise_page.dart';
import 'package:apps_skripsi/features/Lesson%20Exercise/excercise_provider.dart';
import 'package:apps_skripsi/features/Lesson%20Summary/summary_page.dart';
import 'package:apps_skripsi/features/Lesson%20Summary/summary_provider.dart';
import 'package:apps_skripsi/features/Lesson%20Video/video_page.dart';
import 'package:apps_skripsi/features/Lesson%20Video/video_provider.dart';
import 'package:apps_skripsi/features/Lesson/lesson_page.dart';
import 'package:apps_skripsi/features/Lesson/lesson_provider.dart';
import 'package:apps_skripsi/features/Register/register_page.dart';
import 'package:apps_skripsi/features/Register/register_provider.dart';
import 'package:apps_skripsi/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/login/login_state.dart';
import 'features/login/login_provider.dart';
import 'features/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
        ChangeNotifierProvider(create: (_) => SummaryProvider())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/home': (context) => const HomePage(),
          '/speaking': (context) => const CoursePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/lesson': (context) => const LessonPage(),
          '/video': (context) => const VideoPage(),
          '/excercise': (context) => const ExcercisePage(),
          '/summary': (context) => const SummaryPage(),
          '/excercise-detail': (context) => const ExcerciseDetail(),
          '/daily-event': (context) => const DailyPage(),
          '/wrapper': (context) => const Wrapper()
        },
        debugShowCheckedModeBanner: false,
        home: const AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> _checkToken() async {
    final token = await Token().getToken();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          return snapshot.data == false ? const LoginPage() : const Wrapper();
        }
      },
    );
  }
}