import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/core/utils/shared_preferences.dart';
import 'package:apps_skripsi/features/Course/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String? tokenAkun = "";
  bool _idSet = false;

  @override
  void initState() {
    super.initState();
    _initializeTokenAndFetchData();
  }

  Future<void> _initializeTokenAndFetchData() async {
    tokenAkun = await Token().getToken();
    _fetchCourseData();
  }

  void _fetchCourseData() {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    courseProvider.fetchCourse(courseProvider.categoryCourse, tokenAkun ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Tipografi()
            .S1(isiText: "Courses - Speaking", warnaFont: Warna.primary1),
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchCourseData();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<CourseProvider>(
                  builder: (context, courseProvider, child) {
                if (courseProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (courseProvider.errorMessage != null) {
                  return Center(
                    child: Text(
                      courseProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                if (courseProvider.course != null) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(courseProvider),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildLessonList(courseProvider)
                      ],
                    ),
                  );
                }
                return const Center(child: Text("No course data available"));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(CourseProvider courseProvider) {
    final courses = courseProvider.course!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_idSet) {
        Provider.of<CourseProvider>(context, listen: false)
            .setIdCourses(courses.courseId ?? '');
        _idSet = true;
      }
    });
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
      color: Warna.primary3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/Group 140.png",
                  width: 100),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Tipografi().S2(
                              isiText: courses.coursesName ?? '',
                              warnaFont: Warna.primary1),
                        ),
                        _buildDropdownButton()
                      ],
                    ),
                    const SizedBox(height: 5),
                    Tipografi().C(
                        isiText: courses.description ?? '',
                        warnaFont: Warna.primary1),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tipografi()
                            .S2(isiText: "Progress", warnaFont: Warna.primary1),
                        Tipografi().B2(
                            isiText: "${courses.progress}%",
                            warnaFont: Warna.primary1),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      barRadius: const Radius.circular(8),
                      lineHeight: 6.0,
                      percent: (courses.progress ?? 0) / 100,
                      backgroundColor: Warna.primary2,
                      progressColor: Warna.primary4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownButton() {
    return Consumer<CourseProvider>(
      builder: (context, courseProvider, _) {
        return DropdownButton<String>(
          value: courseProvider.categoryCourse,
          dropdownColor: Warna.primary3,
          style: const TextStyle(color: Warna.primary1),
          iconDisabledColor: Warna.primary1,
          iconEnabledColor: Warna.primary1,
          onChanged: (String? newCategory) {
            courseProvider.categoryCourse = newCategory;
            _fetchCourseData();
          },
          items: courseProvider.categories
              .map<DropdownMenuItem<String>>((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category[0].toUpperCase() + category.substring(1)),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildLessonList(CourseProvider courseProvider) {
    final courses = courseProvider.course!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: courses.listLessons!.length,
        itemBuilder: (context, index) {
          final lesson = courses.listLessons![index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/lesson',
                  arguments: lesson.idLesson);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(bottom: 15.0),
              decoration: BoxDecoration(
                color: Warna.primary1,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2.0,
                    offset: const Offset(0, 2),
                    color: Warna.netral1.withOpacity(0.07),
                  ),
                  BoxShadow(
                    blurRadius: 1.0,
                    offset: const Offset(0, 3),
                    color: Warna.netral1.withOpacity(0.06),
                  ),
                  BoxShadow(
                    blurRadius: 10.0,
                    offset: const Offset(0, 1),
                    color: Warna.netral1.withOpacity(0.1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/Rectangle 131.png",
                      width: 100), // Adjust image width for small screens
                  const SizedBox(width: 10), // Adjust spacing for small screens
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tipografi().S1(
                          isiText: lesson.lessonsName ?? '',
                          warnaFont: Warna.netral1,
                        ),
                        const SizedBox(height: 5.0),
                        Tipografi().C(
                          isiText: lesson.description ?? '',
                          warnaFont: Warna.netral4,
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                barRadius: const Radius.circular(8),
                                lineHeight: 6.0,
                                percent: (lesson.progress ?? 0) / 100,
                                backgroundColor: Warna.primary2,
                                progressColor: Warna.primary4,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tipografi().B2(
                              isiText: "${lesson.progress}%",
                              warnaFont: Warna.netral1,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.info_outline),
                              color: Warna.primary1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
