import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Lesson%20Exercise/excercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExcerciseDetail extends StatelessWidget {
  const ExcerciseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final idExercise = ModalRoute.of(context)?.settings.arguments.toString();
    final exercise = Provider.of<ExerciseProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      exercise.loadExercise(idExercise ?? '');
    });
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Warna.primary3,
          title: Tipografi()
              .s1(isiText: 'Score Exercise', warnaFont: Warna.primary1),
        ),
        body: Consumer<ExerciseProvider>(
          builder: (context, exerciseProvider, _) {
            if (exerciseProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (exerciseProvider.errorMessage != null) {
              return const Center(
                child: Text('Data Not Found!'),
              );
            }
            if (exerciseProvider.exerciseApi == null) {
              return const Center(
                child: Text('Data Not Defined'),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Warna.primary1,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tipografi().h6(
                          isiText: exerciseProvider.totalGrade! >= 75
                              ? 'Good job'
                              : 'Try Again',
                          warnaFont: Warna.netral1),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/images/Clip path group.png'),
                      const SizedBox(
                        height: 10,
                      ),
                      Tipografi().s1(
                          isiText: 'Score: ${exerciseProvider.totalGrade}',
                          warnaFont: Warna.netral1),
                      const SizedBox(
                        height: 10,
                      ),
                      if (exerciseProvider.totalGrade! < 75)
                        Tombol().primarySmall(
                            teksTombol: 'Retry',
                            lebarTombol: double.maxFinite,
                            navigasiTombol: () {
                              Navigator.pushReplacementNamed(
                                  context, '/excercise',
                                  arguments:
                                      exerciseProvider.exerciseApi!.exerciseId);
                            }),
                      const SizedBox(
                        height: 5,
                      ),
                      Tombol().outLineSmall(
                          teksTombol: 'Back To Lesson',
                          lebarTombol: double.maxFinite,
                          navigasiTombol: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/lesson'));
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
