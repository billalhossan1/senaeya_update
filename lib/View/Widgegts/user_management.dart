import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../Utils/AppColors/app_colors.dart';
import '../../Utils/AppImg/app_img.dart';
import '../Screens/add_customer_screen/controller/add_customer_screen_controller.dart';
import '../Widgets/custom_phone_text_filed/custom_phone_text_filed.dart';
import 'customUserTextFiled.dart';
import 'custom_button/next_button.dart';

class WorkshopManagement extends StatelessWidget {
  const WorkshopManagement({
    super.key,
    required this.formKey1,
    required this.controller,
  });

  final GlobalKey<FormState> formKey1;
  final AddCustomerScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFieldWithButton(
            controller:
            controller.workshopPhone,
            hintText: 'xxxxxxxxx',
            prefix: '+9665',

            // validator: (value) {
            //   final v = (value ?? '').trim();
            //   if (v.isEmpty) {
            //     return 'phone_number_required'.tr;
            //   }
            //   if (!RegExp(r'^[0-9]{8}$')
            //       .hasMatch(v)) {
            //     return 'phone_number_invalid'.tr;
            //   }
            //   return null;
            // },
            keyboardType: TextInputType.phone,
            onTextChanged: (phone) =>
                controller
                    .setWorkShopPhone(phone),
            onButtonTap: () {
              controller.isFromNewInvoice
                  ? controller.checkPhone()
                  : controller.verifiedPhone(
                  controller
                      .getFullWorkshopPhone(
                      controller
                          .workPhone));
            },
          ),
          // CustomPhoneFieldWithButton(
          //   controller: controller.workshopPhone,
          //   isCountryCodeFixed: false,
          //   hintText: "+966 5xxxxxxxx",
          //   onButtonTap: () {
          //     controller.isFromNewInvoice
          //         ? controller.checkPhone()
          //         : controller.verifiedPhone(
          //         controller.workPhone);
          //   },
          //   onPhoneChanged: (phone) =>
          //       controller.setWorkShopPhone(phone),
          // ),
          SizedBox(height: 12.h),
          CustomUserInputField(
            controller: controller
                .workShopNameController,
            icon: AppIcon.blueProfile,
            hintText: 'name'.tr,
            isRequired: true,
          ),
          SizedBox(height: 12.h),
          CustomUserInputField(
            validator: (value) {
              final v = (value ?? '').trim();
              if (v.isEmpty) {
                return null; // Optional field
              }
              if (!RegExp(r'^3\d{13}3$')
                  .hasMatch(v)) {
                return 'document_number_invalid'
                    .tr;
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter
                  .digitsOnly,
              LengthLimitingTextInputFormatter(
                  15),
            ],
            controller: controller
                .workShopDocumentNumber,
            icon: AppIcon.id,
            hintText: '3xxxxxx00003'.tr,
          ),

          SizedBox(height: 16.h),
          Row(
            children: [
              NextButton(
                text: "cancel".tr,
                onTap: controller.onCancel,
                backgroundColor:
                AppColors.cancelButton,
                textColor: AppColors.red,
              ),
              SizedBox(width: 16.w),
              NextButton(
                text: controller
                    .isFromNewInvoice
                    ? 'next'.tr
                    : 'addition'.tr,
                onTap: () {
                  if (formKey1.currentState!
                      .validate()) {
                    controller
                        .isFromNewInvoice
                        ? controller
                        .onTapSpareParts()
                        : controller
                        .onTapAddCustomer();
                  } else {
                    return;
                  }
                },
                backgroundColor:
                AppColors.primary,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}