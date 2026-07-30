import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Screens/nav_screen/controller/navigation_controller.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../widget/menu_item_widget.dart';
import 'controller/menu_controller.dart';

class MenuDrawerScreen extends StatelessWidget {
  const MenuDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      init: MenuController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Drawer(
            width: 280.sp,
            child: SizedBox(
              width: 200.w,
              child: Container(
                color: AppColors.primary,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      // Profile Image and Name
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Container(
                                width: 66.w,
                                height: 66.w,
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
                                    child:
                                        controller
                                            .profileImageUrl
                                            .value
                                            .isNotEmpty
                                        ? Image.network(
                                            controller.profileImageUrl.value,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return SvgPicture.asset(
                                                    AppImages.defaultProfile,
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.primary,
                                                  value:
                                                      loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          )
                                        : SvgPicture.asset(
                                            AppImages.defaultProfile,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Exit icon
                     Obx(()=> controller.token.isNotEmpty?Align(
                       alignment: Alignment.topRight,
                       child: Padding(
                         padding: const EdgeInsets.only(right: 20.0),
                         child: GestureDetector(
                           onTap: () {
                             controller.exitApp();
                           },
                           child: Column(
                             children: [
                               SvgPicture.asset(
                                 AppIcon.logout,
                                 height: 30.w,
                                 width: 30.w,
                               ),
                               CustomText(
                                 text: "exit".tr,
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.white,
                               ),
                             ],
                           ),
                         ),
                       ),
                     ):const SizedBox(),),

                      SizedBox(height: 16.h),
                      // Menu items
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 16.w,
                            ),
                            children: [
                              MenuItem(
                                icon: AppIcon.home,
                                label: 'home'.tr,
                                onTap: controller.goToHome,
                              ),
                              Divider(height: 32.h),
                              MenuItem(
                                icon: AppIcon.addWorkItem,
                                label: 'add_works_items'.tr,
                                onTap: controller.goToAddWorks,
                              ),
                              MenuItem(
                                icon: AppIcon.appExplain,
                                label: 'app_explain'.tr,
                                onTap: controller.goToAppExplain,
                              ),
                              MenuItem(
                                icon: AppIcon.termsAndCondition,
                                label: 'terms_conditions'.tr,
                                onTap: controller.goToTerms,
                              ),
                              MenuItem(
                                icon: AppIcon.about,
                                label: 'about_us'.tr,
                                onTap: controller.goToAboutUs,
                              ),
                              Divider(height: 32.h),
                              MenuItem(
                                icon: AppIcon.review,
                                label: 'app_rating'.tr,
                                onTap: controller.goToAppRating,
                              ),
                              MenuItem(
                                icon: AppIcon.appShare,
                                label: 'app_sharing'.tr,
                                onTap: controller.goToAppSharing,
                              ),
                              Divider(height: 32.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  'contact_us'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: SvgPicture.asset(AppImages.facebook,height: 42.sp,width: 42.sp,),
                                    onPressed: () =>
                                        controller.onTapFacebook(facebookUrl: 'https://www.facebook.com/senaeya')
                                  ),
                                  IconButton(
                                    icon: Image.asset(AppImages.youtube,height: 42.sp,width: 42.sp,),
                                    onPressed: () =>
                                        controller.onTapYoutube(youtubeUrl: 'https://youtube.com/@senaeya_app')
                                  ),
                                  IconButton(
                                    icon: Image.asset(AppImages.tiktok,height: 42.sp,width: 42.sp,),
                                    onPressed: () =>
                                        controller.onTapTiktok(tiktokUrl: 'https://www.tiktok.com/@senaeya_app')
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              GetBuilder<NavigationController>(
                                builder: (navController) {
                                  return Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'app_version'.tr + '\n',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: navController.appVersion.value,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
