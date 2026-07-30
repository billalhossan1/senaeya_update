import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Service/internet_connectivity.dart'; // তোমার path অনুযায়ী ঠিক করো

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color titleColor;
  final VoidCallback? onBack;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? backButtonColor;
  final bool homeIcon;
  final bool blackHomeIcon;
  final bool whiteHomeIcon;

  CustomAppBar({
    super.key,
    required this.title,
    required this.titleColor,
    this.onBack,
    this.homeIcon = false,
    this.blackHomeIcon = false,
    this.whiteHomeIcon = false,
    this.centerTitle = true,
    this.backgroundColor,
    this.backButtonColor,
  });

  final InternetController internetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: SafeArea(
        child: Row(
          children: [
            if (onBack != null)
              IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: backButtonColor ?? Colors.black),
                onPressed: onBack,
              ),
            if (onBack != null ||
                homeIcon == true ||
                blackHomeIcon == true ||
                whiteHomeIcon == true)
              SizedBox(width: 8.w),
            if (onBack == null &&
                homeIcon == false &&
                blackHomeIcon == false &&
                whiteHomeIcon == false)
              IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.transparent),
                onPressed: () {},
              ),
            if (homeIcon == true ||
                blackHomeIcon == true ||
                whiteHomeIcon == true)
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoute.navScreen);
                },
                child: SvgPicture.asset(
                  homeIcon == true
                      ? AppIcon.home
                      : blackHomeIcon == true
                      ? AppIcon.blackHome
                      : AppIcon.whiteHome,
                  width: 26.w,
                  height: 26.w,
                ),
              ),
            if (onBack == null) SizedBox(width: 8.w),

            // Title
            Expanded(
              child: Align(
                alignment:
                centerTitle ? Alignment.center : Alignment.centerLeft,
                child: CustomText(
                  text: title,
                  textAlign:
                  centerTitle ? TextAlign.center : TextAlign.start,
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  minFontSize: 8,
                ),
              ),
            ),

            // 🔥 Real-time Internet Status Cloud Icon
            Obx(() {
              bool connected = internetController.isConnected.value;
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: SizedBox(
                  width: 38.w,
                  height: 38.w,
                  child: Center(
                    child: SvgPicture.asset(
                      connected
                          ? AppIcon.blueCloud
                          : AppIcon.redCloud,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
