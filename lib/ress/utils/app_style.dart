import 'package:flutter/material.dart';

class AppStyle {
  static AppStyle instance = AppStyle();

  TextStyle textStyle({
    required double fontSize,
    TextOverflow overflow = TextOverflow.clip,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      overflow: overflow,
    );
  }
}
