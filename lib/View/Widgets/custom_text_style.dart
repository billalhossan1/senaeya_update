import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle customTextStyle({
  double? fontSize,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
}) {
  return TextStyle(
    fontFamily: 'Calibri',
    fontSize: (fontSize ?? 14).w,
    fontWeight: fontWeight,
    color: color,
    decoration: decoration,
  );
}
