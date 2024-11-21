import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:flutter/material.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Warna.primary3,
          iconTheme: const IconThemeData(color: Warna.primary1),
          title:
              Tipografi().S1(isiText: 'Daily Event', warnaFont: Warna.primary1),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Warna.primary1,
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
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tipografi().S1(
                              isiText: 'Selesaikan 2 Sub Materi',
                              warnaFont: Warna.netral1),
                          Tipografi().C(
                              isiText: '*Materi Listening',
                              warnaFont: Warna.netral1)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 38,
                              height: 36,
                              child: Image.asset(
                                'assets/images/Group 138.png',
                                fit: BoxFit.fill,
                              )),
                          Tipografi().C(isiText: '10', warnaFont: Warna.netral1)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 36,
                              height: 38,
                              child: Image.asset(
                                'assets/images/Group 137.png',
                                fit: BoxFit.fill,
                              )),
                          Tipografi().C(isiText: '10', warnaFont: Warna.netral1)
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
