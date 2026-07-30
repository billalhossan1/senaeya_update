import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../auth_screens/login_screen/widgets/custom_text_field.dart';

Widget requiredField(
    TextEditingController controller,
    String hint, {
      bool requiredDouble = false,
      bool requiredSingle = false,
      int manxLines = 1,
      bool isTaxNumber = false,
      bool readOnly = false,
      List<TextInputFormatter>? inputFormatters,
      TextInputType keyboardType = TextInputType.text,
      double? fontSize,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextFormField(
              inputFormatters: inputFormatters,
              controller: controller,
              hintText: hint,
              maxLines: manxLines,
              keyboardType: keyboardType,
              isRightStar: false,
              centerHintText: true,
              fontSize: fontSize,
              validator: isTaxNumber ? (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return 'This field is required'.tr;
                if (!v.startsWith('3')) {
                  return 'tax_number_must_start_with_3'.tr;
                }
                if (!v.endsWith('3')) {
                  return 'tax_number_must_end_with_3'.tr;
                }
                if (v.length != 15) {
                  return 'tax_number_must_be_15_digits'.tr;
                }
                return null;
              } : null,
              // Show two stars only when requiredDouble is true.
              // Show one star when requiredSingle is true and requiredDouble is false.
              showOneStar: (!requiredDouble) && requiredSingle,
              showTwoStar: requiredDouble,
              readOnly: readOnly,
            ),
          ),
        ],
      ),
    ],
  );
}