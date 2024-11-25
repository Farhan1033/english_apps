import 'package:apps_skripsi/core/theme/color_primary.dart';
import 'package:flutter/material.dart';

class AreaTeks {
  Widget normal(
      {required bool keamanan,
      Icon? iconIsi,
      IconButton? iconBelakang,
      required String textIsi,
      Color? colorIcondisabled,
      TextEditingController? editingController}) {
    return TextFormField(
      controller: editingController,
      obscureText: keamanan,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Warna.primary4)),
          floatingLabelStyle: TextStyle(color: Warna.primary4),
          alignLabelWithHint: true,
          prefixIcon: iconIsi,
          prefixIconColor: colorIcondisabled,
          suffixIcon: iconBelakang,
          labelText: textIsi,
          labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }

  Widget teksCheck(
      {required String textIsi,
      TextEditingController? editingController,
      required BorderRadius radius}) {
    return TextFormField(
      controller: editingController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: Warna.primary4)),
          floatingLabelStyle: TextStyle(color: Warna.primary4),
          alignLabelWithHint: true,
          hintText: textIsi,
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: radius)),
    );
  }
}
