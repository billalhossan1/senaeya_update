import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../auth_screens/login_screen/widgets/custom_text_field.dart';

Widget customTextFiled(
    TextEditingController controller,
    String hint, {
      bool requiredDouble = false,
      bool requiredSingle = false,
      bool showNoStar = false,
      int manxLines = 1,
      List<TextInputFormatter>? inputFormatters,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextFormField(
              fontSize: 18.sp,

              controller: controller,
              hintText: hint,
              maxLines: manxLines,
              isRightStar: false,
              centerHintText: true,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              validator: validator,
              showOneStar: showNoStar
                  ? false
                  : requiredSingle
                  ? true
                  : requiredDouble
                  ? false
                  : true,
              showTwoStar: requiredDouble ? true : false,
            ),
          ),
        ],
      ),
    ],
  );
}