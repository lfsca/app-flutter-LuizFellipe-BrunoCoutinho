import 'package:flutter/material.dart';

class Style {
  static const baseTextStyle = TextStyle(fontFamily: 'Poppins');
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);
  static final regularTextStyle = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.w400);
  static final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
  static final commonTextStyle = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400);
}
