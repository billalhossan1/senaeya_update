import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeCard extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const HomeCard({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
          child: Column(
            // Distribute available vertical space so children don't overflow
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image kept at its size but allowed to flex if necessary
              Flexible(
                fit: FlexFit.loose,
                child: SvgPicture.asset(icon, height: 74.h, width: 48.w),
              ),
              SizedBox(height: 12.h),
              // Allow label to wrap to two lines and shrink if needed without overflowing
              Flexible(
                fit: FlexFit.loose,
                child: CustomText(
                  text: label,
                  textAlign: TextAlign.center,
                  fontSize: 16, // pass raw value; CustomText applies .sp internally
                  minFontSize: 10,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}