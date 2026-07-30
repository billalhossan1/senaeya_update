import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_text_field.dart';
import 'package:Senaeya/View/Screens/menu/contact_us_screen/controller/contact_us_controller.dart';
import 'package:Senaeya/View/Screens/nav_screen/controller/navigation_controller.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    NavigationController navigationController = Get.find<NavigationController>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GetBuilder<ContactUsController>(
        init: ContactUsController(),
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
                                  if(navigationController.currentIndex.value==3){
                                    navigationController.currentIndex.value=0;
                                    return;
                                  }
                                  Get.back();
                                },
                                child: SvgPicture.asset(AppIcon.whiteHome),
                              ),
                              Expanded(
                                child: CustomText(
                                  text: 'contact_us'.tr,
                                  fontSize: 18,
                                  minFontSize: 8,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
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
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 32.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(text: 'name'.tr, fontSize: 16, minFontSize: 12),
                                CustomTextFormField(
                                  controller: controller.nameController,
                                  hintText: 'full_name'.tr,
                                  centerHintText: true,
                                ),
                                SizedBox(height: 10.h),
                                CustomText(
                                  text: 'mobile_no'.tr,
                                  fontSize: 16,
                                  minFontSize: 12,
                                ),

                                IntlPhoneField(
                                  pickerDialogStyle: PickerDialogStyle(
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: 'Search Country/Region'.tr,
                                    ),
                                  ),
                                  controller: controller.phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'phone_number'.tr,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                  initialCountryCode: 'SA',
                                  onChanged: (phone) {
                                    controller.phoneNumber=phone.countryCode+phone.number;
                                    // You can do something with the phone number here
                                  },
                                ),
                                SizedBox(height: 10.h),
                                CustomText(text: 'message'.tr, fontSize: 16, minFontSize: 12),
                                CustomTextFormField(
                                  centerHintText: true,
                                  inputDecoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),

                                  ),
                                  color: Colors.transparent,
                                  controller: controller.messageController,
                                  hintText: 'type_message_here'.tr,
                                  maxLines: 5,
                                ),
                                SizedBox(height: 16.h),
                                Obx(
                                  () => CustomButton(
                                    text: controller.isLoading.value
                                        ? "Sending...".tr
                                        : "send".tr,
                                    onPressed: () {
                                      controller.contactUs(onTapOk:(){
                                        if(navigationController.currentIndex.value==3){
                                          Navigator.pop(context);
                                          navigationController.currentIndex.value=0;
                                          return;
                                        }else{
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                    backgroundColor: controller.isLoading.value
                                        ? Colors.grey
                                        : null,
                                  ),
                                ),
                                SizedBox(height: 32.h),
                                Center(
                                  child: Text(
                                    'or_contact_us_via_whatsapp'.tr,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Center(
                                  child: InkWell(
                                    onTap: () async {
                                      const whatsappNumber = '966570673000';
                                      // final message = Uri.encodeComponent(
                                      //   'Hello, I want to contact you',
                                      // );
                                      const whatsappUrl =
                                          'https://wa.me/$whatsappNumber';
                                      final uri = Uri.parse(whatsappUrl);
                                      try {
                                        await launchUrl(
                                          uri,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } catch (e) {
                                        showCustomSnackBar(
                                          "install_whatsapp".tr,
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 56.w,
                                      height: 56.w,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF25D366),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/whatsapp.png',
                                          width: 36.w,
                                          height: 36.w,
                                          color: Colors.white,
                                        ),
                                      ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
