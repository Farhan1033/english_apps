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
    final idSummary = ModalRoute.of(context)?.settings.arguments?.toString();
    if (idSummary != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<SummaryProvider>(context, listen: false)
            .summaryData(idSummary);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
        title: Tipografi().S1(isiText: 'Summary', warnaFont: Warna.primary1),
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

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                color: Warna.primary1,
                child: summaryApi.url != null
                    ? SfPdfViewer.network('${summaryApi.url}')
                    : Center(
                        child: Tipografi().S1(
                          isiText: "File Belum Tersedia",
                          warnaFont: Warna.netral1,
                        ),
                      ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Download
                  Tombol().PrimaryLarge(
                    teksTombol: "Download",
                    lebarTombol: MediaQuery.of(context).size.width * 0.44,
                    navigasiTombol: () {
                      if (summaryApi.url != null) {
                        print('URL untuk download: ${summaryApi.url}');
                        // Logika untuk mendownload file bisa ditambahkan di sini
                      } else {
                        print('URL tidak tersedia untuk download');
                      }
                    },
                  ),
                  // Tombol Done
                  Tombol().OutLineLarge(
                    teksTombol: 'Done',
                    lebarTombol: MediaQuery.of(context).size.width * 0.44,
                    navigasiTombol: () {
                      summaryProvider.summaryCompleted(context);
                      Future.delayed(Duration(seconds: 3), () {
                        Provider.of<LessonProvider>(context, listen: false)
                            .lessonFetch(Provider.of<LessonProvider>(context,
                                    listen: false)
                                .idLesson);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
