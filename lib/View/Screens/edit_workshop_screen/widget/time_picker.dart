import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Utils/AppImg/app_img.dart';
import '../../../Widgegts/custom_text/custom_text.dart';
import '../controller/edit_workshop_controller.dart';

Widget timePicker(Rx<TimeOfDay> time, EditWorkshopController controller) {
  return Obx(
        () => InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: Get.context!,
          initialTime: time.value,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(
                  context,
                ).colorScheme.copyWith(primary: const Color(0xFF0C5CA8)),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          time.value = picked;
        }
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F8),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: time.value.format(Get.context!),
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              SvgPicture.asset(AppIcon.dropDown),
            ],
          ),
        ),
      ),
    ),
  );
}
