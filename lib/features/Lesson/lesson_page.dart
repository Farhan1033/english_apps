import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'lesson_provider.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final idCourses = ModalRoute.of(context)?.settings.arguments.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (idCourses != null) {
        Provider.of<LessonProvider>(context, listen: false)
            .setIDLesson(idCourses);
      }
      Provider.of<LessonProvider>(context, listen: false)
          .lessonFetch(idCourses ?? '');
    });

    return Scaffold(
      appBar: AppBar(
        title:
            Tipografi().s1(isiText: 'Lesson Page', warnaFont: Warna.primary1),
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
      ),
      body: Consumer<LessonProvider>(
        builder: (context, lessonProvider, _) {
          final lesson = lessonProvider.lessonApi;
          if (lessonProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (lessonProvider.errorMessage != null) {
            return Center(
                child: Text('Error: ${lessonProvider.errorMessage!}'));
          }
          if (lessonProvider.lessonApi == null) {
            return const Center(child: Text('No lesson data available.'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  lessonProvider.lessonFetch(lessonProvider.idLesson);
                },
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20),
                    decoration: const BoxDecoration(color: Warna.primary3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Rectangle 11.png"),
                                      fit: BoxFit.fill)),
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Tipografi().h6(
                                      isiText: lesson!.lessonName ?? "",
                                      warnaFont: Warna.primary1),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Warna.primary4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Tipografi().C(
                                          isiText: "Speaking",
                                          warnaFont: Warna.primary1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: LinearPercentIndicator(
                                          padding: const EdgeInsets.all(0),
                                          barRadius: const Radius.circular(8),
                                          lineHeight: 6.0,
                                          percent:
                                              (lesson.totalProgress! / 100),
                                          backgroundColor: Warna.primary2,
                                          progressColor: Warna.primary4,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Tipografi().C(
                                          isiText: "${lesson.totalProgress}%",
                                          warnaFont: Warna.primary1)
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final lesson = lessonProvider.lessonApi!;
                        if (index == 0) {
                          return selectedLesson(
                            navigasi: () {
                              Navigator.pushNamed(context, '/video',
                                  arguments: lesson.video!.videoId ?? '');
                            },
                            isCompleted: lesson.video?.isCompleted ?? false,
                            dataExp: lesson.video?.videoExp.toString(),
                            dataPoint: lesson.video?.videoPoint.toString(),
                            dataTitle: lesson.video?.videoTitle ?? "",
                          );
                        } else if (index == 1) {
                          return selectedLesson(
                            navigasi: () {
                              Navigator.pushNamed(context, '/excercise',
                                  arguments: lesson.exercise!.exerciseId);
                            },
                            isCompleted: lesson.exercise?.isCompleted ?? false,
                            dataExp: lesson.exercise?.exerciseExp.toString(),
                            dataPoint:
                                lesson.exercise?.exercisePoint.toString(),
                            dataTitle: "Exercise",
                          );
                        } else if (index == 2) {
                          return selectedLesson(
                            navigasi: () {
                              Navigator.pushNamed(
                                context,
                                '/summary',
                                arguments: lesson.summary!.summaryId,
                              );
                            },
                            isCompleted: lesson.summary?.isCompleted ?? false,
                            dataTitle: "Summary",
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row selectedLesson(
      {required bool isCompleted,
      String? dataUrl,
      String? dataExp,
      String? dataPoint,
      required String dataTitle,
      required VoidCallback navigasi}) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: isCompleted == true ? Warna.benar : Warna.netral6,
              shape: BoxShape.circle),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              isCompleted == true ? Icons.check : Icons.close,
              color: Warna.primary1,
              size: 16,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: GestureDetector(
            onTap: navigasi,
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                  color: Warna.primary1,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2.0,
                      offset: const Offset(0, 2),
                      spreadRadius: 0.0,
                      color: Warna.netral1.withOpacity(0.07),
                    ),
                    BoxShadow(
                      blurRadius: 1.0,
                      offset: const Offset(0, 3),
                      spreadRadius: 0.0,
                      color: Warna.netral1.withOpacity(0.06),
                    ),
                    BoxShadow(
                      blurRadius: 10.0,
                      offset: const Offset(0, 1),
                      spreadRadius: 0.0,
                      color: Warna.netral1.withOpacity(0.1),
                    ),
                  ]),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 56,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: dataUrl != null
                                ? NetworkImage(dataUrl)
                                : const AssetImage(
                                        "assets/images/Rectangle 11.png")
                                    as ImageProvider)),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tipografi()
                            .s1(isiText: dataTitle, warnaFont: Warna.primary4),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.circle_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Tipografi().b2(
                                    isiText: "${dataExp ?? '0'} EXP",
                                    warnaFont: Warna.netral1)
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.currency_rupee_sharp),
                                const SizedBox(
                                  width: 5,
                                ),
                                Tipografi().b2(
                                    isiText: dataPoint ?? '0',
                                    warnaFont: Warna.netral1)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
