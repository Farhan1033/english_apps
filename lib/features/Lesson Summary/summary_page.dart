import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Lesson%20Summary/summary_provider.dart';
import 'package:apps_skripsi/features/Lesson/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final idSummary = ModalRoute.of(context)?.settings.arguments.toString();
      final summaryContext = context.read<SummaryProvider>();
      if (idSummary != null) {
        summaryContext.summaryData(idSummary);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
        title: Tipografi().s1(isiText: 'Summary', warnaFont: Warna.primary1),
      ),
      body: Consumer<SummaryProvider>(builder: (context, summaryProvider, _) {
        if (summaryProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (summaryProvider.errorMessage != null) {
          return const Center(
            child: Text('Data Summary Not Found'),
          );
        }
        if (summaryProvider.summaryAPI == null) {
          return const Center(
            child: Text('Data Not Found'),
          );
        }

        final summaryApi = summaryProvider.summaryAPI!;

        return LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: isLandscape
                        ? constraints.maxHeight * 0.75
                        : constraints.maxHeight * 0.85,
                    child: Container(
                      width: double.infinity,
                      color: Warna.primary1,
                      child: summaryApi.url != null
                          ? SfPdfViewer.network('${summaryApi.url}')
                          : Center(
                              child: Tipografi().s1(
                                isiText: "File Belum Tersedia",
                                warnaFont: Warna.netral1,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Tombol().primaryLarge(
                    teksTombol: 'Done',
                    lebarTombol: double.maxFinite,
                    navigasiTombol: () {
                      final lesson = context.read<LessonProvider>();
                      if (lesson.lessonApi!.summary!.isCompleted ==
                          false) {
                        summaryProvider.summaryCompleted(context);
                        Future.delayed(const Duration(seconds: 2), () {
                          lesson.lessonFetch(lesson.idLesson);
                          Navigator.popUntil(
                              // ignore: use_build_context_synchronously
                              context, ModalRoute.withName('/lesson'));
                        });
                      } else {
                        lesson.lessonFetch(lesson.idLesson);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/lesson'));
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
