import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Utils/AppImg/app_img.dart';

class CarsCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;
  final bool isSelected;

  const CarsCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:  8.0,right: 8),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 100.w,
                      child: Center(
                        child: Image.network(
                          "${ApiConstant.imageBaseUrl}$imagePath",
                          width: 80.w,
                          height: 80.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomText(
                     text:  title,
                      textAlign: TextAlign.center,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,

                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 28,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected ? SvgPicture.asset(
                AppIcon.check,
                height: 24.w,
                width: 24.w,
              ) : const SizedBox()
            ),
          ),
        ],
      ),
    );
  }
}