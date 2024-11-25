import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:apps_skripsi/core/theme/typography.dart';
import 'package:flutter/material.dart';

var tipografri = Tipografi();

class Tombol {
  Widget primaryLarge(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: WidgetStatePropertyAll(Size(lebarTombol, 51)),
            backgroundColor: WidgetStatePropertyAll(Warna.primary3),
            overlayColor: WidgetStatePropertyAll(Warna.primary4)),
        child: tipografri.fontButton(
            isiText: teksTombol, warnaFont: Warna.primary1));
  }

  Widget primarySmall(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: WidgetStatePropertyAll(Size(lebarTombol, 36)),
            backgroundColor: WidgetStatePropertyAll(Warna.primary3),
            overlayColor: WidgetStatePropertyAll(Warna.primary4)),
        child: tipografri.fontButton(
            isiText: teksTombol, warnaFont: Warna.primary1));
  }

  Widget outLineLarge(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: WidgetStatePropertyAll(Size(lebarTombol, 51)),
            side: WidgetStatePropertyAll(BorderSide(color: Warna.primary3)),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            overlayColor:
                WidgetStatePropertyAll(Warna.primary4.withOpacity(0.5))),
        child: tipografri.fontButton(
            isiText: teksTombol, warnaFont: Warna.primary3));
  }

  Widget outLineSmall(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return ElevatedButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: WidgetStatePropertyAll(Size(lebarTombol, 36)),
            side: WidgetStatePropertyAll(BorderSide(color: Warna.primary3)),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            overlayColor:
                WidgetStatePropertyAll(Warna.primary4.withOpacity(0.5))),
        child: tipografri.fontButton(
            isiText: teksTombol, warnaFont: Warna.primary3));
  }

  // ignore: non_constant_identifier_names
  Widget TextLarge(
      {required String teksTombol,
      required double lebarTombol,
      required VoidCallback navigasiTombol}) {
    return TextButton(
        onPressed: navigasiTombol,
        style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(lebarTombol, 51)),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            overlayColor:
                WidgetStatePropertyAll(Warna.primary4.withOpacity(0.2))),
        child: tipografri.fontButton(
            isiText: teksTombol, warnaFont: Warna.primary3));
  }
}
