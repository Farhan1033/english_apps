import 'package:apps_skripsi/core/models/analysis_detail_api.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Analysis/analysis_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class AnalysisDetailPage extends StatelessWidget {
  const AnalysisDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalysisDetailProvider>().analysisDetail();
    });
    return Scaffold(
      appBar: AppBar(
        title: Tipografi()
            .S1(isiText: "Analysis Detail", warnaFont: Warna.primary1),
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
      ),
      body: Consumer<AnalysisDetailProvider>(
        builder: (context, analysisDetailProvider, _) {
          if (analysisDetailProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (analysisDetailProvider.hasError) {
            return const Center(child: Text('Database not found!'));
          }
          if (analysisDetailProvider.analysisDetailApi == null) {
            return const Center(child: Text('Data not found!'));
          }
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
              child: ListView.builder(
                itemCount:
                    analysisDetailProvider.analysisDetailApi!.data!.length,
                itemBuilder: (context, index) {
                  final item =
                      analysisDetailProvider.analysisDetailApi!.data![index];
                  if (index == 0) {
                    return _buildAnalysisCategory(
                        context, item, 'assets/images/Component 1.png');
                  } else if (index == 1) {
                    return _buildAnalysisCategory(
                        context, item, 'assets/images/Property 1=Writting.png');
                  } else if (index == 2) {
                    return _buildAnalysisCategory(context, item,
                        'assets/images/Property 1=Listening.png');
                  } else if (index == 3) {
                    return _buildAnalysisCategory(
                        context, item, 'assets/images/Property 1=Reading.png');
                  } else {
                    return Container();
                  }
                },
              ));
        },
      ),
    );
  }

  Container _buildAnalysisCategory(
      BuildContext context, Data item, String imageCourse) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      width: double.maxFinite,
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
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowContent(context, item, imageCourse),
          Tipografi().S1(isiText: 'Skill Level', warnaFont: Warna.netral1),
          _buildColumnSkillLevel(context, item.progress ?? []),
        ],
      ),
    );
  }

  Widget _buildRowContent(
      BuildContext context, Data analysis, String imageCourse) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 81,
          height: 88,
          child: Image.asset(imageCourse),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tipografi()
                  .H6(isiText: analysis.course ?? '', warnaFont: Warna.netral1),
              Tipografi().B2(
                  isiText: analysis.description ?? '', warnaFont: Warna.netral1)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildColumnSkillLevel(
      BuildContext context, List<Progress> progressList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
        itemCount: progressList.length,
        itemBuilder: (context, index) {
          final item = progressList[index];
          if (index == 0) {
            return _bulildSkillLevel(
                context, item.category ?? '', item.progressPercentage ?? 0);
          } else if (index == 1) {
            return _bulildSkillLevel(
                context, item.category ?? '', item.progressPercentage ?? 0);
          } else if (index == 2) {
            return _bulildSkillLevel(
                context, item.category ?? '', item.progressPercentage ?? 0);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Container _bulildSkillLevel(
    BuildContext context, String category, int progressPercentage) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    width: double.maxFinite,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tipografi().B2(isiText: category, warnaFont: Warna.netral1),
            Tipografi().B2(
                isiText: '${progressPercentage.toString()}%',
                warnaFont: Warna.netral1),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: LinearPercentIndicator(
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(8),
            lineHeight: 6.0,
            percent: progressPercentage / 100,
            width: MediaQuery.of(context).size.width * 0.8,
            progressColor: Warna.primary4,
            backgroundColor: Warna.primary2,
          ),
        )
      ],
    ),
  );
}
