import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Utils/AppImg/app_img.dart';
import '../../../Widgegts/custom_text/custom_text.dart';

Widget dayDropdown(RxString day) {
  final dayKeys = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];

  return Obx(() {
    if (day.value.isEmpty || !dayKeys.contains(day.value.toLowerCase())) {
      day.value = dayKeys.first;
    } else {
      day.value = day.value.toLowerCase();
    }

    return Container(
      height: 34.w,
      // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F8),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          icon: SvgPicture.asset(AppIcon.dropDown),
          value: day.value,
          isExpanded: true,

          underline: const SizedBox(),
          style: const TextStyle(color: Colors.black87, fontSize: 10),
          items: dayKeys
              .map(
                (key) => DropdownMenuItem(
              value: key,
              child: CustomText(text: key.tr, fontSize: 11.w),
            ),
          )
              .toList(),
          onChanged: (val) {
            if (val != null) {
              day.value = val;
            }
          },
        ),
      ),
    );
  });
}