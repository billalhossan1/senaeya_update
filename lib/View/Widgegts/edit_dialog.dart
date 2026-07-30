import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/AppColors/app_colors.dart';
import '../../Utils/ToastMsg/toast_message.dart';
import '../Screens/add_spare_parts_screen/controller/add_spare_parts_controller.dart';
import '../Widgets/custom_dropdown.dart';
import 'custom_text/custom_text.dart';
import 'custom_text_field/custom_text_field.dart';

void showEditDialog(
    BuildContext context,
    AddSparePartsController controller,
    int index,
    ) {
  // Load the work data into controller form fields
  controller.editWork(index);

  Get.dialog(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'edit_spare_part'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Code Dropdown
                  Obx(() {
                    // Ensure selected code is present in the dropdown items
                    final codes = controller.availableCodes.toList();
                    if (controller.selectedCode.value.isNotEmpty &&
                        !codes.contains(controller.selectedCode.value)) {
                      codes.insert(0, controller.selectedCode.value);
                    }
                    return CustomDropdown<String>(
                      value: controller.selectedCode.value.isEmpty
                          ? null
                          : controller.selectedCode.value,
                      items: codes,
                      hint: 'code'.tr,
                      onChanged: controller.onCodeChanged,
                      height: 45,
                      width: double.infinity,
                      borderRadius: 24,
                      fillColor: AppColors.textFiledColor,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      hintStyle: const TextStyle(color: Colors.grey),
                      itemStyle: const TextStyle(fontSize: 14),
                    );
                  }),
                  const SizedBox(height: 8),
                  // Works
                  CustomTextField(
                    initialValue: controller.workName.value,
                    hintText: 'works'.tr,
                    onChanged: controller.onWorkNameChanged,
                    height: 45,
                  ),
                  const SizedBox(height: 8),
                  // Qty
                  Obx(
                        () => CustomDropdown<int>(
                      value: controller.qty.value > 0
                          ? controller.qty.value
                          : null,
                      items: List.generate(20, (i) => i + 1),
                      hint: 'Qty'.tr,
                      onChanged: (val) {
                        if (val != null) {
                          controller.onQtyChanged(val.toString());
                        }
                      },
                      height: 45,
                      width: double.infinity,
                      borderRadius: 24,
                      fillColor: AppColors.textFiledColor,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      hintStyle: const TextStyle(color: Colors.grey),
                      itemStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Price
                  CustomTextField(
                    initialValue: controller.price.value.toString(),
                    hintText: 'price'.tr,
                    keyboardType: TextInputType.number,
                    onChanged: controller.onPriceChanged,
                    height: 45,
                  ),
                  const SizedBox(height: 8),
                  // New/Used toggle
                  Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => controller.isNew.value = true,
                          child: Row(
                            children: [
                              CustomText(
                                text: 'new'.tr,
                                fontSize: 14,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.circle,
                                color: controller.isNew.value
                                    ? Colors.green
                                    : Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => controller.isNew.value = false,
                          child: Row(
                            children: [
                              CustomText(
                                text: 'used'.tr,
                                fontSize: 14,
                                color: AppColors.red,
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.circle,
                                color: !controller.isNew.value
                                    ? AppColors.red
                                    : Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redTextFiled,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: CustomText(
                            text: 'cancel'.tr,
                            color: AppColors.red,
                            fontSize: 16.sp,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          onPressed: () {
                            // Validate and update using controller method
                            if (controller.selectedCode.value.isEmpty ||
                                controller.workName.value.isEmpty) {
                              showCustomSnackBar(
                                " 'please_fill_all_required_fields'.tr,",
                                isError: true,
                              );
                              return;
                            }
                            controller.updateWork(index);
                            Navigator.pop(context);
                          },
                          child: CustomText(
                            text: 'save'.tr,
                            color: Colors.white,
                            fontSize: 16.sp,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),)
  );
}