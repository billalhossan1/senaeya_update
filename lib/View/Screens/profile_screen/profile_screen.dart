import 'dart:io';
import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Helper/shared_prefe/shared_prefe.dart';
import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Screens/auth_screens/login_screen/widgets/custom_button.dart';
import 'package:Senaeya/View/Screens/previous_invoices_screen/common_parse_date/converted_date.dart';
import 'package:Senaeya/View/Screens/profile_screen/controller/profile_screen_controller.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenController controller =
        Get.find<ProfileScreenController>();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF1771B7),
        appBar: CustomAppBar(
          title: "profile_title".tr,
          titleColor: Colors.black,
          centerTitle: true,
          //blueCloud: true,
          blackHomeIcon: true,
        ),
        body: FutureBuilder<String>(
          future: SharePrefsHelper.getString(
            SharedPreferenceValue.subscriptionId,
          ),
          builder: (context, snapshot) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 12,
                  left: 4,
                  right: 4,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 0.92.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      // Make the scrollable content take remaining space
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Profile image with edit icon overlay
                              SizedBox(height: 8.h),
                              Obx(
                                () => Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      width: 110.w,
                                      height: 110.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 3.w,
                                          color: AppColors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(100.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0.r),
                                        child: ClipOval(
                                          child: controller.isUploading.value
                                              ? const Center(
                                                  child: CircularProgressIndicator(
                                                    color: Color(0xFF1771B7),
                                                  ),
                                                )
                                              : _buildProfileImage(controller),
                                        ),
                                      ),
                                    ),
                                    if (!controller.isUploading.value)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () =>
                                              controller.showImageSourceDialog(),
                                          child: const CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Color(0xFF1771B7),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h),
                              // Workshop Manager Data card
                              _DataCard(
                                title: 'workshop_manager_data'.tr,
                                onTap: () {
                                  Get.toNamed(AppRoute.editProfileScreen);
                                },
                              ),
                              SizedBox(height: 16.h),
                              // Workshop Data card
                              _DataCard(
                                title: 'workshop_data'.tr,
                                onTap: () {
                                  Get.toNamed(AppRoute.editWorkshopScreen);
                                },
                              ),
                              SizedBox(height: 24.h),
                              // After subscribe - show only if subscriptionId exists and is not empty
                              Obx(
                                () => controller.subscriptionIsLoading.value
                                    ? const Center(child: CircularProgressIndicator())
                                    : Column(
                                        children: [
                                          if (controller.currentSubscription.value != null)
                                            _SubscriptionCard(
                                              isActive: true,
                                              controller: controller,
                                            ),
                                          if (controller.currentSubscription.value != null)
                                            SizedBox(height: 20.h),
                                          // Before subscribe - show only if subscriptionId is empty
                                          if (controller.currentSubscription.value == null)
                                             _SubscriptionCard(isActive: false,controller: controller,),
                                        ],
                                      ),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      // Delete button pinned to bottom of white card
                      CustomButton(
                        onPressed: () {
                          controller.exitApp();
                        },
                        text: "Delete Account".tr,
                        backgroundColor: AppColors.redTextFiled,
                        textColor: AppColors.red,
                        enabled: true,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build profile image widget based on available image source
  Widget _buildProfileImage(ProfileScreenController controller) {
    debugPrint('====> Building profile image');
    debugPrint('====> Local path: ${controller.profileImagePath.value}');
    debugPrint('====> Network URL: ${controller.networkImageUrl.value}');

    // Priority: Local file > Network image > Default SVG
    if (controller.profileImagePath.value.isNotEmpty) {
      // Show local file image
      debugPrint('====> Showing local file image');
      return Image.file(
        File(controller.profileImagePath.value),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('====> Error loading local image: $error');
          return SvgPicture.asset(AppImages.defaultProfile, fit: BoxFit.fill);
        },
      );
    } else if (controller.networkImageUrl.value.isNotEmpty) {
      // Show network image
      debugPrint(
        '====> Showing network image: ${controller.networkImageUrl.value}',
      );
      return CachedNetworkImage(
        imageUrl: controller.networkImageUrl.value,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          debugPrint('====> Loading image from: $url');
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF1771B7)),
          );
        },
        errorWidget: (context, url, error) {
          debugPrint('====> Error loading network image: $error');
          return SvgPicture.asset(AppImages.defaultProfile, fit: BoxFit.fill);
        },
      );
    } else {
      // Show default SVG image
      debugPrint('====> Showing default SVG image');
      return SvgPicture.asset(AppImages.defaultProfile, fit: BoxFit.fill);
    }
  }
}

// Helper widgets
class _DataCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _DataCard({required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Row(
        children: [
          CustomText(text: title, fontSize: 18.sp, fontWeight: FontWeight.w500),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.edit, color: Color(0xFFBDBDBD), size: 20),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final bool isActive;
  final ProfileScreenController controller;
  const _SubscriptionCard({required this.isActive, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE49894),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isActive) ...[
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: 'subscribed_to'.tr,
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: CustomText(
                    text: 'activated'.tr,
                    fontSize: 12.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.center,
              child: CustomText(
                text: 'full_services'.tr,
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.center,
              child: CustomText(
                text: 'Ends IN ${FormateDateTime.formatDateTimeForSubscription(controller.currentSubscription.value!.currentPeriodEnd!)}',
                fontSize: 12.sp,
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.topCenter,
              child: CustomButton(
                fontSize: 18.w,
                text: "View Invoice".tr,
                width: 150.w,
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.toNamed(AppRoute.invoiceScreen,arguments: {"subscriptionId":controller.currentSubscription.value?.sId??''});
                },
                textColor: AppColors.primary,
                height: 40.h,
              ),
            ),
          ] else ...[
            Center(
              child: Column(
                children: [
                  CustomText(
                    text: 'not_subscribed'.tr,
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: 'to_full_service'.tr,
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.topCenter,
                    child: CustomButton(
                      fontSize: 16.w,
                      text: 'subscribe_now'.tr,
                      width: 180.w,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Get.toNamed(AppRoute.subscriptionScreen);
                      },
                      textColor: AppColors.primary,
                      height: 40.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
