import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../login_screen/widgets/custom_text_field.dart';
import 'controller/forgot_screen_controller.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotScreenController>(
        init: ForgotScreenController(),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              appBar: CustomAppBar(
                title: "forgot_password_title".tr,
                titleColor: Colors.black,
                // //blueCloud: true,
                onBack: () => Navigator.pop(context),
              ),
              backgroundColor: const Color(0xFF1766A0),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               CustomText(text: "forgot_password_instruction_1".tr,fontSize: 18.w,),
                               SizedBox(height: 6.h,),
                               CustomText(text: "forgot_password_instruction_2".tr,fontSize: 18.w,),
                              SizedBox(height: 24.h,),

                              CustomTextFormField(
                                hintText: 'forgot_password_hint'.tr,
                                icon: AppIcon.phone,
                                keyboardType: TextInputType.phone,
                                controller: controller.phoneController,
                                prefix: '+9665',
                                maxDigits: 13,
                              ),
                              SizedBox(height: 16.h),
                              Obx(() => CustomButton(
                                    onPressed: controller.onTapForget,
                                    text: 'forgot_password_button'.tr,
                                    isLoading: controller.isLoading.value,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
