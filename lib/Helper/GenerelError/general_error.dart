import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/Widgegts/custom_text/custom_text.dart';

class GeneralErrorScreen extends StatelessWidget {
  const GeneralErrorScreen({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const CustomImage(imageSrc: AppImages.noInternetImage),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              text: "Something wrong!",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.primary,
                  minimumSize: Size(Get.width / 1.6, 40.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32.r),
                        bottomLeft: Radius.circular(32.r),
                      ))),
              child: const CustomText(
                text: "Try Again",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
