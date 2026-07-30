import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../Utils/AppColors/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 18,
    this.minFontSize = 6, // 👈 added
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
  final double minFontSize; // 👈 added
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final String fontFamily;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: AutoSizeText(
        text.tr,
        textAlign: textAlign,
        maxLines: maxLines,
        minFontSize: minFontSize,
        stepGranularity: 0.1,
        wrapWords: true,
        overflow: overflow,
        style: TextStyle(
          fontFamily: fontFamily,
          // Use .sp so ScreenUtil's text scaling works well with AutoSizeText
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
        ),
      ),
    );
  }
}
