import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = TextStyle(fontFamily: 'Poppins');
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);
  static final regularTextStyle = baseTextStyle.copyWith(
      color: Color.fromARGB(218, 250, 227, 227),
      fontSize: 9.0,
      fontWeight: FontWeight.w400);
  static final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 14.0,
      fontWeight: FontWeight.w400);
}
