import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

import 'controller/terms_and_condition_controller.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GetBuilder<TermsAndConditionController>(
        init: TermsAndConditionController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  // Blue header section with app bar
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 90.h,
                        color: AppColors.primary,
                      ),
                      // App Bar
                      Positioned(
                        bottom: 10.h,
                        left: 10.w,
                        right: 0,
                        child: Container(
                          height: 70.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: SvgPicture.asset(AppIcon.whiteHome),
                              ),
                              Expanded(
                                child: CustomText(
                                  text: 'terms_and_conditions'.tr,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 48.w), // Balance the back button
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70.h,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30.h,
                          decoration: const BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Main content area
                  Expanded(
                    child: Container(
                      color: AppColors.red,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r),
                          ),
                        ),
                        // Ensure the white container always fills the space
                        child: SizedBox.expand(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 32.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => controller.isloading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primary,
                                            ),
                                          )
                                        : HtmlWidget(
                                            controller
                                                    .termsAndConditionModel
                                                    .value
                                                    ?.data?.content ??
                                                '',
                                            textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
