import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:apps_skripsi/features/Lesson%20Exercise/excercise_provider.dart';
import 'package:apps_skripsi/features/Lesson/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ExcercisePage extends StatefulWidget {
  const ExcercisePage({super.key});

  @override
  State<ExcercisePage> createState() => _ExcercisePageState();
}

class _ExcercisePageState extends State<ExcercisePage> {
  String? idExcercise;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final idExcercise = ModalRoute.of(context)?.settings.arguments.toString();
      final excerciseProv =
          Provider.of<ExerciseProvider>(context, listen: false);
      if (idExcercise != null) {
        excerciseProv.loadExercise(idExcercise);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Tipografi().s1(isiText: "Excercise", warnaFont: Warna.primary1),
        iconTheme: const IconThemeData(color: Warna.primary1),
        backgroundColor: Warna.primary3,
      ),
      body: Consumer<ExerciseProvider>(
        builder: (context, excerciseProvider, _) {
          final excercise = excerciseProvider.exerciseApi;
          if (excerciseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (excerciseProvider.errorMessage != null) {
            return Center(
              child: Text(
                'Error : ${excerciseProvider.errorMessage!}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (excercise == null || excercise.quiz == null) {
            return const Center(
              child: Text('No Exercise Available'),
            );
          }
          final dataQuiz = excercise.quiz![excerciseProvider.currentIndex];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatBox(
                        icon: Icons.favorite,
                        value: excerciseProvider.exercisePoints.toString(),
                        color: Warna.salah,
                      ),
                      _buildCountdownTimer(
                        duration: excercise.exerciseDuration ?? 0,
                        onFinished: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Timer is done!')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildQuestionBox(
                    question: dataQuiz.question,
                    currentIndex: excerciseProvider.currentIndex + 1,
                    totalQuestions: excercise.quiz!.length,
                  ),
                  const SizedBox(height: 15),
                  _buildAnswerChoices(dataQuiz, excerciseProvider),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Tombol().primaryLarge(
                        teksTombol: excerciseProvider.currentIndex + 1 <
                                excerciseProvider.exerciseApi!.quiz!.length
                            ? "Next"
                            : "Finish",
                        lebarTombol: MediaQuery.of(context).size.width * 0.4,
                        navigasiTombol: excerciseProvider.isAnswerSelected
                            ? () {
                                if (excerciseProvider.currentIndex + 1 <
                                    excerciseProvider
                                        .exerciseApi!.quiz!.length) {
                                  excerciseProvider.nextQuiz();
                                } else {
                                  if (excerciseProvider.statusKelulusan ==
                                      'Tidak Lulus') {
                                    excerciseProvider.resetQuiz();
                                    showResultDialog(
                                        context, excerciseProvider);
                                  } else {
                                    final idLesson =
                                        Provider.of<LessonProvider>(context,
                                            listen: false);
                                    final idCourse =
                                        Provider.of<CourseProvider>(context,
                                                listen: false)
                                            .idCourses;
                                    if (idLesson
                                            .lessonApi!.exercise!.isCompleted ==
                                        false) {
                                      excerciseProvider.resetQuiz();
                                      excerciseProvider.completeExercise(
                                          idCourse, idLesson.idLesson);
                                      showResultDialog(
                                          context, excerciseProvider);
                                    } else {
                                      excerciseProvider.resetQuiz();
                                      showResultDialog(
                                          context, excerciseProvider);
                                    }
                                  }
                                }
                              }
                            : CircularProgressIndicator.new),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showResultDialog(
      BuildContext context, ExerciseProvider exerciseProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Warna.primary1,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Warna.primary1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tipografi().h6(
                  isiText: exerciseProvider.totalGrade! >= 75
                      ? 'Good job'
                      : 'Try Again',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 10),
                Image.asset('assets/images/Clip path group.png'),
                const SizedBox(height: 10),
                Tipografi().s1(
                  isiText: 'Score: ${exerciseProvider.totalGrade}',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 10),
                if (exerciseProvider.totalGrade! < 75)
                  Tombol().primarySmall(
                    teksTombol: 'Retry',
                    lebarTombol: double.maxFinite,
                    navigasiTombol: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/excercise',
                        arguments: exerciseProvider.exerciseApi!.exerciseId,
                      );
                    },
                  ),
                const SizedBox(height: 5),
                Tombol().outLineSmall(
                  teksTombol: 'Back To Lesson',
                  lebarTombol: double.maxFinite,
                  navigasiTombol: () {
                    Future.delayed(const Duration(seconds: 2), () {
                      // ignore: use_build_context_synchronously
                      final lesson = context.read<LessonProvider>();
                      lesson.lessonFetch(lesson.idLesson);
                      Navigator.popUntil(
                          // ignore: use_build_context_synchronously
                          context, ModalRoute.withName('/lesson'));
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatBox({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      height: 44,
      width: 64,
      decoration: BoxDecoration(
        color: Warna.primary1,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: const Offset(0, 2),
            color: Warna.netral1.withOpacity(0.07),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: color),
          Text(value, style: const TextStyle(color: Warna.netral1)),
        ],
      ),
    );
  }

  Widget _buildCountdownTimer({
    required int duration,
    required VoidCallback onFinished,
  }) {
    return Container(
      height: 44,
      width: 98,
      decoration: BoxDecoration(
        color: Warna.primary1,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: const Offset(0, 2),
            color: Warna.netral1.withOpacity(0.07),
          ),
        ],
      ),
      child: Countdown(
        seconds: duration,
        build: (_, double time) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.timer, color: Warna.netral1),
            Text(time.toStringAsFixed(0),
                style: const TextStyle(color: Warna.netral1)),
          ],
        ),
        interval: const Duration(milliseconds: 100),
        onFinished: onFinished,
      ),
    );
  }

  Widget _buildQuestionBox({
    required String? question,
    required int currentIndex,
    required int totalQuestions,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Tipografi().C(
              isiText: '$currentIndex/$totalQuestions',
              warnaFont: Warna.netral1,
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Tipografi().b1(
              isiText: question ?? 'No Question Available',
              warnaFont: Warna.netral1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerChoices(dataQuiz, ExerciseProvider excerciseProvider) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        dataQuiz.answer!.length,
        (index) => ChoiceChip(
          label: Text(dataQuiz.answer![index]),
          selected: excerciseProvider.selectedAnswerIndex == index,
          onSelected: excerciseProvider.isAnswerSelected
              ? null
              : (bool selected) {
                  excerciseProvider.checkAndSetAnswer(index, context);
                },
        ),
      ),
    );
  }
}
