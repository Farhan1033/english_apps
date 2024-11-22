import 'package:flutter/material.dart';

class Tipografi {
  Widget H1({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 96.0,
          color: warnaFont),
    );
  }

  Widget H2({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 60.0,
          color: warnaFont),
    );
  }

  Widget H3({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 48.0,
          color: warnaFont),
    );
  }

  Widget H4({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 34.0,
          color: warnaFont),
    );
  }

  Widget H5({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 24.0,
          color: warnaFont),
    );
  }

  Widget H6({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          color: warnaFont),
    );
  }

  Widget S1({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          color: warnaFont),
    );
  }

  Widget S2({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: warnaFont),
    );
  }

  Widget B1({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: warnaFont),
    );
  }

  Widget B2({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          color: warnaFont),
    );
  }

  Widget FontButton({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: warnaFont),
    );
  }

  Widget C({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 12.0,
          color: warnaFont),
    );
  }

  Widget O({required String isiText, required Color warnaFont}) {
    return Text(
      isiText,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 10.0,
          color: warnaFont),
    );
  }
}
