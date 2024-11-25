import 'dart:convert';
import 'package:apps_skripsi/core/models/event_lesson.dart';
import 'package:apps_skripsi/core/models/video_api.dart';
import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/core/utils/localhost.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:apps_skripsi/features/Lesson%20Video/custom_vide.dart';
import 'package:apps_skripsi/features/Lesson/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  VideoApi? videoApi;
  EventLesson? eventLesson;
  bool isFinish = false;
  bool hasDialogShown = false;

  int countFinish = 0;

  Future<void> getVideoApi() async {
    final token = await Token().getToken();
    // ignore: use_build_context_synchronously
    final idVideo = ModalRoute.of(context)?.settings.arguments.toString();
    final response = await http.get(
      Uri.parse("http://${Localhost.localhost}/video-parts/$idVideo"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        videoApi = VideoApi.fromJson(jsonData['data']);
        isFinish = true;
      });
      initializeVideoPlayer();
    } else {
    }
  }

  Future<void> videoCompleted() async {
    final token = await Token().getToken();
    // ignore: use_build_context_synchronously
    final lesson = Provider.of<LessonProvider>(context, listen: false).idLesson;
    final course =
        // ignore: use_build_context_synchronously
        Provider.of<CourseProvider>(context, listen: false).idCourses;
    final respons = await http.put(
        Uri.parse('http://${Localhost.localhost}/update_progress_lesson'),
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode(
            {'lesson_id': lesson, 'course_id': course, 'event_type': 'video'}));

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      eventLesson = EventLesson.fromJson(jsonData['data']);
    } else {
    }
  }

  @override
  void initState() {
    super.initState();
    getVideoApi();
  }

  Future<void> initializeVideoPlayer() async {
    if (videoApi == null) {
      return;
    }
    String url = videoApi!.url ?? "";
    String encodeURL = url.replaceAll(" ", "%20");

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(encodeURL))
          ..addListener(checkVideoEnd);

    await videoPlayerController.initialize();
    setState(() {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        autoInitialize: true,
        looping: false,
        showControls: true,
        materialProgressColors:
            ChewieProgressColors(playedColor: Warna.primary4),
        allowPlaybackSpeedChanging: true,
        draggableProgressBar: false,
        customControls: const CustomMaterialControls(
          showPlayButton: true,
        ),
        allowFullScreen: true,
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],
      );
    });
  }

  void checkVideoEnd() {
    if (!hasDialogShown &&
        videoPlayerController.value.position >=
            videoPlayerController.value.duration) {
      setState(() {
        hasDialogShown = true;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Tipografi().s1(
              isiText: "Video Telah Selesai Ditonton",
              warnaFont: Warna.netral1),
          content: Container(
            child: Tipografi().b2(
                isiText: "Klik Next Untuk Melanjutkan",
                warnaFont: Warna.netral1),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tutup"),
            ),
            Consumer<LessonProvider>(
              builder: (context, lessonProvider, _) {
                return Tombol().primarySmall(
                  teksTombol: "Next",
                  lebarTombol: double.infinity,
                  navigasiTombol: () {
                    if (lessonProvider.lessonApi!.video!.isCompleted == false) {
                      videoCompleted();
                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          getVideoApi();
                          Navigator.popUntil(
                              // ignore: use_build_context_synchronously
                              context, ModalRoute.withName('/lesson'));
                        },
                      );
                    } else {
                      getVideoApi();
                      Navigator.popUntil(
                          context, ModalRoute.withName('/lesson'));
                    }
                  },
                );
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    videoPlayerController.removeListener(checkVideoEnd);
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
        title: const Text(
          "Video",
          style: TextStyle(color: Warna.primary1),
        ),
      ),
      body: videoApi == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (chewieController != null &&
                        chewieController!
                            .videoPlayerController.value.isInitialized)
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Chewie(controller: chewieController!),
                      )
                    else
                      const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Tipografi().h6(
                                  isiText:
                                      videoApi?.title ?? "Video Tidak Tersedia",
                                  warnaFont: Warna.netral1),
                              const SizedBox(height: 16),
                              Tipografi().s1(
                                  isiText: 'Description',
                                  warnaFont: Warna.netral1),
                              const SizedBox(height: 8),
                              Tipografi().b2(
                                  isiText: videoApi?.description ??
                                      "Video Tidak Tersedia",
                                  warnaFont: Warna.netral1),
                            ],
                          ),
                          if (isFinish)
                            Tombol().primaryLarge(
                              teksTombol: "Finish",
                              lebarTombol: double.maxFinite,
                              navigasiTombol: () {
                                Navigator.pop(context);
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
