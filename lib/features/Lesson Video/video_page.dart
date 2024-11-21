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
    final idVideo = ModalRoute.of(context)?.settings.arguments.toString();
    final response = await http.get(
      Uri.parse(
          "http://${Localhost.localhost}:8080/api/v1/video-parts/$idVideo"),
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
      print("Error: ${response.body}");
    }
  }

  Future<void> videoCompleted() async {
    final token = await Token().getToken();
    final lesson = Provider.of<LessonProvider>(context, listen: false).idLesson;
    final course =
        Provider.of<CourseProvider>(context, listen: false).idCourses;
    final respons = await http.put(
        Uri.parse(
            'http://${Localhost.localhost}:8080/api/v1/update_progress_lesson'),
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode(
            {'lesson_id': lesson, 'course_id': course, 'event_type': 'video'}));

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      eventLesson = EventLesson.fromJson(jsonData['data']);
    } else {
      print('Error: ${respons.body}');
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
        allowPlaybackSpeedChanging: true,// Nonaktifkan kecepatan pemutaran
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
        videoCompleted();
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Tipografi().S1(
              isiText: "Video Telah Selesai Ditonton",
              warnaFont: Warna.netral1),
          content: Container(
            child: Tipografi().B2(
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
                return Tombol().PrimarySmall(
                  teksTombol: "Next",
                  lebarTombol: double.infinity,
                  navigasiTombol: () {
                    setState(() {
                      getVideoApi();
                      Navigator.popUntil(
                          context, ModalRoute.withName('/lesson'));
                    });
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
                              Tipografi().H6(
                                  isiText:
                                      videoApi?.title ?? "Video Tidak Tersedia",
                                  warnaFont: Warna.netral1),
                              const SizedBox(height: 16),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Tipografi().B2(
                                  isiText: videoApi?.description ??
                                      "Video Tidak Tersedia",
                                  warnaFont: Warna.netral1),
                            ],
                          ),
                          if (isFinish)
                            Tombol().PrimaryLarge(
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