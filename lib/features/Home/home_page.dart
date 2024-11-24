import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:apps_skripsi/features/Home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).gamifikasi();
      Provider.of<HomeProvider>(context, listen: false).progressLesson();
      final course = Provider.of<CourseProvider>(context, listen: false);
      course.fetchCourse(course.categoryCourse);
    });
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          if (homeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (homeProvider.hasError != false) {
            return const Center(
              child: Text('Data not valid'),
            );
          }
          if (homeProvider.gamifikasiApi == null) {
            return const Center(
              child: Text('Data not found!'),
            );
          }
          final home = homeProvider.gamifikasiApi!;
          final progress = homeProvider.progressApi;
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              homeProvider.gamifikasi();
              homeProvider.progressLesson();
            },
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildHeader(
                    context,
                    home.level.toString(),
                    home.totalPoints.toString(),
                    (home.currentExp! / home.nextLevelExp!).toDouble(),
                    progress?.lesson ?? '',
                    progress?.status ?? '',
                    (progress?.progressPercentage ?? 0).toDouble()),
                _buildContent(context),
              ],
            )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
        highlightElevation: 0,
        hoverColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(context, '/daily-event');
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/images/Frame 172.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String level, String poin,
      double progress, String title, String label, double percentProgress) {
    return Container(
      color: Warna.primary3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Column(
        children: [
          _buildLevelAndCurrencyRow(level, poin, progress),
          const SizedBox(
            height: 30,
          ),
          _buildUserProfileRow(),
          const SizedBox(
            height: 30,
          ),
          _buildOngoingCourseCard(context, title, label, percentProgress)
        ],
      ),
    );
  }

  Widget _buildLevelAndCurrencyRow(String level, String poin, double progress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLevelIndicator(level, progress),
        Row(
          children: [
            _buildCurrencyBox(poin),
            const SizedBox(
              width: 20,
            ),
            _buildNotificationIcon()
          ],
        )
      ],
    );
  }

  Widget _buildLevelIndicator(String level, double progress) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Warna.primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tipografi().S2(isiText: 'Level $level', warnaFont: Warna.netral1),
          const SizedBox(
            height: 5,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(8),
            lineHeight: 6.0,
            percent: (progress / 100).clamp(0.0, 1.0),
            width: 84,
            progressColor: Warna.primary4,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyBox(String poin) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Row(
        children: [
          Image.asset('assets/images/Group 137.png'),
          const SizedBox(
            width: 5,
          ),
          Tipografi().S2(isiText: poin, warnaFont: Warna.netral1)
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      height: 44.0,
      width: 44.0,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: const Icon(Icons.notifications, color: Warna.primary3),
    );
  }

  Widget _buildUserProfileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildProfilePicture(),
            const SizedBox(width: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Warna.primary1),
                ),
                Text(
                  "Morgan Breum!",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      color: Warna.primary1),
                ),
              ],
            ),
          ],
        ),
        Image.asset("assets/images/ilus_1.png", width: 71, height: 74.27),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      height: 62,
      width: 62,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image:
            DecorationImage(image: AssetImage("assets/images/Ellipse 8.png")),
      ),
    );
  }

  Widget _buildOngoingCourseCard(BuildContext context, String title,
      String label, double percentProgress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Warna.primary1,
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(1, 0),
              color: Warna.netral1.withOpacity(0.1))
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 600;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isSmallScreen) ...[
                _buildCourseImage("assets/images/Property 1=Speaking.png"),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOngoingLabel(label),
                      const SizedBox(height: 5.0),
                      Tipografi().S1(
                          isiText: title,
                          warnaFont: Warna.netral1,
                          oververFlow: TextOverflow.ellipsis,
                          maxLines: 2)
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _buildCircularProgressIndicator(percentProgress),
              ] else ...[
                Row(
                  children: [
                    _buildCourseImage("assets/images/Property 1=Speaking.png"),
                    const SizedBox(width: 20),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOngoingLabel(label),
                          const SizedBox(height: 5.0),
                          Tipografi().S1(
                              isiText: title,
                              warnaFont: Warna.netral1,
                              oververFlow: TextOverflow.ellipsis,
                              maxLines: 2)
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: _buildCircularProgressIndicator(percentProgress),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildOngoingLabel(String label) {
    return Container(
      height: 22,
      width: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: _getColorBasedOnStatus(label),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Tipografi().C(
        isiText: label,
        warnaFont: Warna.primary1,
      ),
    );
  }

  Color _getColorBasedOnStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Warna.benar;
      case 'ongoing':
        return Warna.ongoing;
      case 'failed':
        return Warna.salah;
      default:
        return Warna.primary1;
    }
  }

  Widget _buildCourseImage(String imagePath) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Warna.primary1,
        image: DecorationImage(image: AssetImage(imagePath)),
        boxShadow: [
          BoxShadow(
              blurRadius: 4.0,
              offset: const Offset(0, 2),
              color: Warna.netral1.withOpacity(0.2))
        ],
      ),
    );
  }

  Widget _buildCircularProgressIndicator(double percentProgress) {
    return CircularPercentIndicator(
      radius: 30.0,
      lineWidth: 6.5,
      percent: percentProgress / 100,
      reverse: true,
      center: Tipografi()
          .C(isiText: percentProgress.toString(), warnaFont: Warna.netral1),
      progressColor: Warna.primary3,
      backgroundColor: Warna.primary2,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(),
          const SizedBox(height: 30),
          _buildLearningChoices(context),
          const SizedBox(height: 30),
          const Text(
            "Recommend For You",
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 16, color: Warna.netral1),
          ),
          const SizedBox(height: 15),
          _buildRecommendationList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Mau Belajar Apa Sekarang?",
        hintStyle: const TextStyle(color: Warna.primary3, fontSize: 14.0),
        prefixIcon: const Icon(Icons.search, color: Warna.primary3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Widget _buildLearningChoices(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildChoiceBox(context, "assets/images/Group 141.png", "Speaking", () {
          Navigator.pushNamed(context, '/speaking');
        }),
        _buildChoiceBox(
            context, "assets/images/Group 142.png", "Reading", () {}),
        _buildChoiceBox(
            context, "assets/images/Group 143.png", "Writing", () {}),
        _buildChoiceBox(
            context, "assets/images/Group 144.png", "Listening", () {}),
      ],
    );
  }

  Widget _buildChoiceBox(BuildContext context, String imagePath, String label,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          _buildCourseImage(imagePath),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
                fontFamily: "Poppins", fontSize: 14, color: Warna.netral1),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationList() {
    return Consumer<CourseProvider>(
      builder: (context, coursesProvider, _) {
        if (coursesProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (coursesProvider.errorMessage != null) {
          return const Center(
            child: Text('Database not found!'),
          );
        }
        if (coursesProvider.course == null) {
          return const Center(
            child: Text('Data not found!'),
          );
        }
        final course = coursesProvider.course!;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: course.listLessons!.length,
            itemBuilder: (context, index) {
              final listCourse = course.listLessons![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/lesson',
                      arguments: listCourse.idLesson);
                },
                child: Container(
                  width: 237,
                  margin: const EdgeInsets.only(right: 12.0, bottom: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Warna.primary1,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          offset: const Offset(0, 2),
                          spreadRadius: 0.0,
                          color: Warna.netral1.withOpacity(0.07)),
                      BoxShadow(
                          blurRadius: 1.0,
                          offset: const Offset(0, 3),
                          spreadRadius: 0.0,
                          color: Warna.netral1.withOpacity(0.06)),
                      BoxShadow(
                          blurRadius: 10.0,
                          offset: const Offset(0, 1),
                          spreadRadius: 0.0,
                          color: Warna.netral1.withOpacity(0.1)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 177,
                        width: 217,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 11.png"))),
                      ),
                      const SizedBox(height: 20.0),
                      Flexible(
                        child: _buildRecommendationHeader(
                            listCourse.lessonsName!, listCourse.description!),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRecommendationHeader(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tipografi().S1(isiText: title, warnaFont: Warna.netral1),
        const SizedBox(height: 5.0),
        Tipografi().B2(isiText: description, warnaFont: Warna.netral1),
      ],
    );
  }
}
