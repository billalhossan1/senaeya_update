import 'package:Senaeya/View/Screens/edit_workshop_screen/widget/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Utils/AppColors/app_colors.dart';
import '../../../Widgegts/custom_text/custom_text.dart';
import '../controller/edit_workshop_controller.dart';
import 'day_dropdown.dart';

Widget workingHoursSection(
    String title,
    RxString dayFrom,
    RxString dayTo,
    Rx<TimeOfDay> from,
    Rx<TimeOfDay> to,
    EditWorkshopController controller,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            ' *',
            style: TextStyle(
              color: AppColors.red,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4.w),
          CustomText(
            text: title,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ],
      ),
      SizedBox(height: 12.h),
      Column(
        children: [
          Row(
            children: [
              // Day dropdown
              Text(
                'from'.tr,
                style: TextStyle(fontSize: 11.sp, color: Colors.black54),
              ),
              SizedBox(width: 4.w),
              Expanded(flex: 2, child: dayDropdown(dayFrom)),
              SizedBox(width: 4.w),
              Text(
                'to'.tr,
                style: TextStyle(fontSize: 11.sp, color: Colors.black54),
              ),
              SizedBox(width: 4.w),
              Expanded(flex: 2, child: dayDropdown(dayTo)),
            ],
          ),
          SizedBox(height: 08.h),
          Row(
            children: [
              Text(
                'from'.tr,
                style: TextStyle(fontSize: 11.sp, color: Colors.black54),
              ),
              SizedBox(width: 4.w),
              // From time picker
              Expanded(flex: 2, child: timePicker(from, controller)),
              SizedBox(width: 4.w),
              // To label
              Text(
                'to'.tr,
                style: TextStyle(fontSize: 11.sp, color: Colors.black54),
              ),
              SizedBox(width: 4.w),
              // To time picker
              Expanded(flex: 2, child: timePicker(to, controller)),
            ],
          ),
        ],
      ),
    ],
  );
}