import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../Utils/AppColors/app_colors.dart';

class Commontextwithoutresize extends StatelessWidget {
  const Commontextwithoutresize({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.navy700,
    this.fontFamily = 'Calibri',
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final String fontFamily;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextDecoration? decoration;

  static TextStyle centerHintStyle({
    double fontSize = 16,
    Color color = AppColors.navy700,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
    String fontFamily = 'Calibri',
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.w,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: Text(
        textAlign: textAlign,
        text.tr,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize.w,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
        ),
      ),
    );
  }
}
