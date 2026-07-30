import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Utils/AppColors/app_colors.dart';
import '../login_screen/widgets/custom_text_field.dart';
import 'controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
        init: ResetPasswordController(),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              appBar: CustomAppBar(
                title: "reset_password".tr,
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
                              CustomText(
                                text: "reset_your_password".tr,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.w,
                              ),
                              SizedBox(height: 10.h),
                              CustomText(
                                text: "enter_new_password_below".tr,
                                fontSize: 18.w,
                              ),
                              SizedBox(height: 24.h),
                              CustomTextFormField(
                                hintText: 'new_password'.tr,
                                icon: AppIcon.lock,
                                keyboardType: TextInputType.visiblePassword,
                                controller: controller.newPasswordController,
                                obscureText: true,
                              ),
                              CustomTextFormField(
                                hintText: 'confirm_password'.tr,
                                icon: AppIcon.lock,
                                keyboardType: TextInputType.visiblePassword,
                                controller: controller.confirmPasswordController,
                                obscureText: true,
                              ),
                              SizedBox(height: 16.h),
                              Obx(() => controller.errorMessage.value.isNotEmpty
                                ? CustomText(
                                    text: controller.errorMessage.value,
                                    color: AppColors.red,
                                  )
                                : const SizedBox()),
                              Obx(() => controller.successMessage.value.isNotEmpty
                                ? CustomText(
                                    text: controller.successMessage.value,
                                    color: Colors.green,
                                  )
                                : const SizedBox()),
                              SizedBox(height: 16.h),
                              Obx(() => CustomButton(
                                onPressed: controller.onTapResetPassword,
                                text: 'reset_password'.tr,
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
