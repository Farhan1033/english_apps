import 'package:apps_skripsi/core/service/event_lesson_models.dart';
import 'package:apps_skripsi/core/service/video_models.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:apps_skripsi/features/Lesson/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:apps_skripsi/core/models/event_lesson.dart';
import 'package:apps_skripsi/core/models/video_api.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoProvider with ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  VideoApi? videoApi;
  final VideoModels videoModels = VideoModels();
  final EventLessonModels eventLessonModels = EventLessonModels();
  EventLesson? eventLesson;
  bool isLoading = false;
  bool hasDialogShown = false;
  bool isFinish = false;

  Future<void> getVideoApi(BuildContext context, String idVideo) async {
    isLoading = true;

    try {
      final token = await Token().getToken();
      final videoData =
          await videoModels.video(idVideo, token ?? 'Token Not Found!');
      if (videoData != null) {
        videoApi = videoData;
        await initializeVideoPlayer(context);
      }
    } catch (e) {
      print('Error : ${e.toString()}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> initializeVideoPlayer(BuildContext context) async {
    if (videoApi == null || videoApi!.url == null) return;

    String url = videoApi!.url!;
    String encodedURL = url.replaceAll(" ", "%20");

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(encodedURL))
          ..addListener(() {
            if (!hasDialogShown &&
                videoPlayerController.value.position >=
                    videoPlayerController.value.duration) {
              hasDialogShown = true;
              final lessonId =
                  Provider.of<LessonProvider>(context, listen: false).idLesson;
              final courseId =
                  Provider.of<CourseProvider>(context, listen: false).idCourses;
              videoCompleted(context, lessonId, courseId);
              Future.delayed(
                Duration(seconds: 1),
                () => getVideoApi(context, videoApi!.id!),
              );
              showCompletionDialog(context);
            }
          });

    await videoPlayerController.initialize();

  }

  Future<void> videoCompleted(
      BuildContext context, String lessonId, String courseId) async {
    try {
      final token = await Token().getToken();

      final response = await eventLessonModels.eventExcerciseCompleted(
          token ?? 'Token Not Found!', lessonId, courseId, 'video');

      if (response != null) {
        eventLesson = response;
        notifyListeners();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Video Telah Selesai Ditonton"),
        content: const Text("Klik Next untuk melanjutkan."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Tutup"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/lesson'));
            },
            child: const Text("Next"),
          ),
        ],
      ),
    );
  }

  void disposeVideoPlayer() {
    videoPlayerController.dispose();
  }
}
