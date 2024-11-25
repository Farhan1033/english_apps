import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().gamifikasi();
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContent(context),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        if (homeProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (homeProvider.hasError) {
          return const Center(
            child: Text('Database not found!'),
          );
        }
        if (homeProvider.gamifikasiApi == null) {
          return const Center(
            child: Text('Data progress not found!'),
          );
        }
        final gamifikasi = homeProvider.gamifikasiApi!;
        return Container(
          color: Warna.primary3,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            children: [
              _buildLevelAndCurrencyRow(
                  gamifikasi.level!,
                  (gamifikasi.currentExp! / gamifikasi.nextLevelExp!)
                      .toDouble(),
                  gamifikasi.totalPoints!),
              const SizedBox(
                height: 30,
              ),
              _buildUserProfileRow(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLevelAndCurrencyRow(int level, double progress, int poin) {
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

  Widget _buildLevelIndicator(int level, double progress) {
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
          Tipografi().S2(
              isiText: 'Level ${level.toString()}', warnaFont: Warna.netral1),
          const SizedBox(
            height: 5,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(8),
            lineHeight: 6.0,
            percent: progress / 100,
            width: 84,
            progressColor: Warna.primary4,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyBox(int poin) {
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
          Tipografi().S2(isiText: poin.toString(), warnaFont: Warna.netral1)
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

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.3,
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
      child: _buildRowAnalysis(context),
    );
  }

  Widget _buildRowAnalysis(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: CircularPercentIndicator(
            radius: MediaQuery.of(context).size.width * 0.15,
            lineWidth: 10,
            percent: 0.9,
            reverse: true,
            progressColor: Warna.primary4,
            backgroundColor: Warna.netral1.withOpacity(0.2),
            center: Tipografi().S1(isiText: '90%', warnaFont: Warna.netral1),
          ),
        ),
        _buildListSkillView(context)
      ],
    );
  }

  Widget _buildListSkillView(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildColumnCategory(context, 'Speaking', 60);
          } else if (index == 1) {
            return _buildColumnCategory(context, 'Listening', 60);
          } else if (index == 2) {
            return _buildColumnCategory(context, 'Reading', 60);
          } else if (index == 3) {
            return _buildColumnCategory(context, 'Writing', 60);
          } else if (index == 4) {
            return Align(
              alignment: Alignment.centerRight,
              child: Tombol().TextLarge(
                  teksTombol: 'See Detail >>',
                  lebarTombol: double.infinity,
                  navigasiTombol: () {
                    Navigator.pushNamed(context, '/analysis-detail');
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Container _buildColumnCategory(
      BuildContext context, String label, int progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(label), Text('${progress.toString()}%')],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.maxFinite,
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(8),
              lineHeight: 6.0,
              percent: 0.6,
              width: MediaQuery.of(context).size.width * 0.4,
              progressColor: Warna.primary4,
              backgroundColor: Warna.primary2,
            ),
          ),
        ],
      ),
    );
  }
}
