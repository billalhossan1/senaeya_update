import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../../Utils/AppColors/app_colors.dart';

class CustomUserInputField extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final String hintText;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final bool enabled;
  final bool isRequired;
  final Color requiredStarColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  /// ✅ New field — controls whether user can edit text
  final bool readOnly;
  /// When true (default) unfocuses the field (hides keyboard) when the user
  /// taps anywhere outside the field. Uses TextFormField.onTapOutside.
  final bool dismissKeyboardOnTapOutside;

  const CustomUserInputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.iconColor = const Color(0xFF1771B7),
    this.backgroundColor,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.enabled = true,
    this.isRequired = false,
    this.requiredStarColor = AppColors.red,
    this.inputFormatters,
    this.validator,
    this.readOnly = false, // default = editable
    this.dismissKeyboardOnTapOutside = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 24.w, width: 24.w),
          SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(fontSize: 16.sp),
              keyboardType: keyboardType,
              obscureText: obscureText,
              maxLines: maxLines,
              enabled: enabled,
              readOnly: readOnly, // 👈 Added here
              // Unfocus the field (hide keyboard) when tapping outside
              onTapOutside: dismissKeyboardOnTapOutside ? (_) => FocusScope.of(context).unfocus() : null,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText.tr,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
          if (isRequired)
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                "*",
                style: TextStyle(
                  color: requiredStarColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
