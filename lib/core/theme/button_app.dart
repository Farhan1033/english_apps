import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:flutter/material.dart';

var tipografri = Tipografi();

class Tombol {
  Widget PrimaryLarge(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: MaterialStatePropertyAll(Size(lebarTombol, 51)),
            backgroundColor: MaterialStatePropertyAll(Warna.primary3),
            overlayColor: MaterialStatePropertyAll(Warna.primary4)),
        child: tipografri.FontButton(
            isiText: teksTombol, warnaFont: Warna.primary1));
  }

  Widget PrimarySmall(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: MaterialStatePropertyAll(Size(lebarTombol, 36)),
            backgroundColor: MaterialStatePropertyAll(Warna.primary3),
            overlayColor: MaterialStatePropertyAll(Warna.primary4)),
        child: tipografri.FontButton(
            isiText: teksTombol, warnaFont: Warna.primary1));
  }

  Widget OutLineLarge(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: MaterialStatePropertyAll(Size(lebarTombol, 51)),
            side: MaterialStatePropertyAll(BorderSide(color: Warna.primary3)),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            overlayColor:
                MaterialStatePropertyAll(Warna.primary4.withOpacity(0.5))),
        child: tipografri.FontButton(
            isiText: teksTombol, warnaFont: Warna.primary3));
  }

  Widget OutLineSmall(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: MaterialStatePropertyAll(Size(lebarTombol, 36)),
            side: MaterialStatePropertyAll(BorderSide(color: Warna.primary3)),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            overlayColor:
                MaterialStatePropertyAll(Warna.primary4.withOpacity(0.5))),
        child: tipografri.FontButton(
            isiText: teksTombol, warnaFont: Warna.primary3));
  }

  Widget TextLarge(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return TextButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(lebarTombol, 51)),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            overlayColor:
                MaterialStatePropertyAll(Warna.primary4.withOpacity(0.2))),
        child: tipografri.FontButton(
            isiText: teksTombol, warnaFont: Warna.primary3));
  }
}
