
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/AppColors/app_colors.dart';
import '../custom_text/custom_text.dart';


class CustomButtonPrev extends StatelessWidget {
  const CustomButtonPrev(
      {super.key,
      this.height = 48,
      this.width = double.maxFinite,
      required this.onTap,
      this.title = "",
      this.marginVerticel = 0,
      this.marginHorizontal = 0,
      this.fillColor =AppColors.navy500,
      this.textColor = AppColors.white100});

  final double height;
  final double width;
  final Color fillColor;
  final Color textColor;

  final VoidCallback onTap;

  final String title;

  final double marginVerticel;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: marginVerticel, horizontal: marginHorizontal),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r), color: fillColor),
        child: CustomText(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 20.w,
            textAlign: TextAlign.center,
            text: title),
      ),
    );
  }
}
