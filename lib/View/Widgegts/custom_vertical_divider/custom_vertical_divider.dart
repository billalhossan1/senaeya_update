import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? thickness;
  final EdgeInsetsGeometry? margin;

  const CustomVerticalDivider({
    super.key,
    this.width,
    this.height,
    this.color,
    this.thickness,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: thickness ?? 1.w,
      height: height ?? 32.h,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(0.5.r),
      ),
    );
  }
}
