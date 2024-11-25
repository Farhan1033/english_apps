import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:apps_skripsi/features/Home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        title:
            Tipografi().s1(isiText: 'Setting Page', warnaFont: Warna.primary1),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            children: [
              // Container(
              //   width: 158,
              //   height: 158,
              //   decoration: const BoxDecoration(shape: BoxShape.circle),
              //   child: Image.asset(
              //     'assets/images/Ellipse 8_1.png',
              //     fit: BoxFit.fill,
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Tipografi().h6(isiText: 'Morgan Bruem', warnaFont: Warna.netral1),
              // const SizedBox(
              //   height: 15,
              // ),
              // Tombol().primaryLarge(
              //     teksTombol: 'Edit Profile',
              //     lebarTombol: double.infinity,
              //     navigasiTombol: () {}),
              // const SizedBox(
              //   height: 15,
              // ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildPreferencyProfile(
                        context, 'About', Icons.info, () {});
                  } else if (index == 1) {
                    return _buildPreferencyProfile(
                        context, 'Logout', Icons.logout, () {
                      Provider.of<HomeProvider>(context, listen: false)
                          .removeToken();
                      Navigator.pushReplacementNamed(context, '/login');
                    });
                  } else {
                    return Container();
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildPreferencyProfile(BuildContext context, String title,
      IconData iconTitle, GestureTapCallback navigasiOnTap) {
    return GestureDetector(
      onTap: navigasiOnTap,
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.1,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
          children: [
            Icon(
              iconTitle,
              size: 35,
              color: Warna.primary3,
            ),
            const SizedBox(
              width: 15,
            ),
            Tipografi().s2(isiText: title, warnaFont: Warna.netral1)
          ],
        ),
      ),
    );
  }
}
