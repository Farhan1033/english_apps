import 'package:flutter/material.dart';

class Tipografi {
  Widget h1({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 96.0,
          color: warnaFont),
    );
  }

  Widget h2({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 60.0,
          color: warnaFont),
    );
  }

  Widget h3({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 48.0,
          color: warnaFont),
    );
  }

  Widget h4({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 34.0,
          color: warnaFont),
    );
  }

  Widget h5({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 24.0,
          color: warnaFont),
    );
  }

  Widget h6({
    required String isiText,
    required Color warnaFont,
  }) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          color: warnaFont),
    );
  }

  Widget s1(
      {required String isiText,
      required Color warnaFont,
      TextOverflow? oververFlow,
      int? maxLines}) {
    return Text(
      isiText,
      overflow: oververFlow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          color: warnaFont),
    );
  }

  Widget s2(
      {required String isiText,
      required Color warnaFont,
      TextOverflow? oververFlow,
      int? maxLines}) {
    return Text(
      isiText,
      overflow: oververFlow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: warnaFont),
    );
  }

  Widget b1(
      {required String isiText,
      required Color warnaFont,
      TextOverflow? oververFlow,
      int? maxLines}) {
    return Text(
      isiText,
      overflow: oververFlow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: warnaFont),
    );
  }

  Widget b2(
      {required String isiText,
      required Color warnaFont,
      TextOverflow? oververFlow,
      int? maxLines}) {
    return Text(
      isiText,
      overflow: oververFlow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          color: warnaFont),
    );
  }

  Widget fontButton({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: warnaFont),
    );
  }

  Widget C(
      {required String isiText,
      required Color warnaFont,
      TextOverflow? oververFlow,
      int? maxLines}) {
    return Text(
      isiText,
      overflow: oververFlow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 12.0,
          color: warnaFont),
    );
  }

  Widget O(
      {required String isiText,
      required Color warnaFont,
      TextOverflow? oververFlow,
      int? maxLines}) {
    return Text(
      isiText,
      overflow: oververFlow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 10.0,
          color: warnaFont),
    );
  }
}
