import 'package:apps_skripsi/core/models/reward_api.dart';
import 'package:apps_skripsi/core/theme/button_app.dart';
import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Home/home_provider.dart';
import 'package:apps_skripsi/features/Reward/reward_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RewardProvider>().reward();
      context.read<HomeProvider>().gamifikasi();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        title:
            Tipografi().S1(isiText: 'Reward Page', warnaFont: Warna.primary1),
      ),
      body: SingleChildScrollView(
        child: Consumer<RewardProvider>(
          builder: (context, rewardProvider, _) {
            if (rewardProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (rewardProvider.hasError != null) {
              return const Center(child: Text('Database not found!'));
            }
            if (rewardProvider.rewardApi == null) {
              return const Center(child: Text('Data not found!'));
            }
            final item = rewardProvider.rewardApi!.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Tipografi().H6(
                        isiText: 'Tukarkan Poin Anda Sekarang Juga',
                        warnaFont: Warna.netral1),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildMyPoin(context),
                  const SizedBox(
                    height: 15,
                  ),
                  Tipografi()
                      .H6(isiText: 'Pilih Hadiah', warnaFont: Warna.netral1),
                  const SizedBox(
                    height: 5,
                  ),
                  Tipografi().B2(
                      isiText: 'Tukar hadiah sesuai jumlah poin yang tersedia',
                      warnaFont: Warna.netral1),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: item!.length,
                    itemBuilder: (context, index) {
                      final listItem = item[index];
                      final imagePaths = [
                        'assets/images/help_icon.png',
                        'assets/images/unlimited_hearts.png',
                        'assets/images/double_exp.png',
                      ];
                      if (index < imagePaths.length) {
                        return _buildReedemReward(
                            context, listItem, imagePaths[index]);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMyPoin(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        if (homeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (homeProvider.hasError) {
          return const Center(child: Text('Database not found!'));
        }
        if (homeProvider.gamifikasiApi == null) {
          return const Center(child: Text('Data not found!'));
        }
        final gamifikasi = homeProvider.gamifikasiApi;
        return Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
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
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.06,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Image.asset(
                    'assets/images/Component 1_poin.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tipografi()
                          .B1(isiText: 'Poin Anda', warnaFont: Warna.netral1),
                      Tipografi().H6(
                          isiText: '${gamifikasi!.totalPoints.toString()} poin',
                          warnaFont: Warna.netral1)
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Container _buildReedemReward(
      BuildContext context, Data item, String imageItems) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.14,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.06,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Image.asset(
              imageItems,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tipografi().B2(isiText: item.name!, warnaFont: Warna.netral1),
                Tipografi().S1(
                    isiText: '${item.points!.toString()} poin',
                    warnaFont: Warna.netral1)
              ],
            ),
          ),
          Tombol().PrimarySmall(
              teksTombol: 'Reedem',
              lebarTombol: double.infinity,
              navigasiTombol: () {
                context.read<RewardProvider>().showDialogRedeem(
                    context,
                    imageItems,
                    item.name ?? '',
                    item.points ?? 0,
                    item.description ?? '',
                    item.terms ?? '');
              })
        ],
      ),
    );
  }
}
