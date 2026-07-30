import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Custom input formatter for VIN validation
class VinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Check length limit (max 17 characters)
    if (newText.length > 17) {
      return oldValue;
    }

    // Check each character
    // for (int i = 0; i < newText.length; i++) {
    //   String char = newText[i];
    //
    //   // Check if it's a digit
    //   // if (RegExp(r'[0-9]').hasMatch(char)) {
    //   //   // Only allow digits 1-4 and 6-9 (0 and 5 are not allowed)
    //   //   // if (char == '0' || char == '5') {
    //   //   //   return oldValue;
    //   //   // }
    //   // }
    //   // Letters and other characters are allowed (no restriction)
    // }

    return newValue;
  }
}

class VinTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final double? iconSize;
  final VoidCallback? onTapIcon;
  final Color? backgroundColor;
  final bool enabled;
  final Function(String)? onChanged;
  final bool isRequired; // Show red star for required field
  /// When true (default) the field will unfocus (hide keyboard) when the user
  /// taps outside the field. This uses TextField.onTapOutside when available.
  final bool dismissKeyboardOnTapOutside;

  const VinTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.iconSize,
    this.onTapIcon,
    this.backgroundColor,
    this.enabled = true,
    this.onChanged,
    this.isRequired = false,
    this.dismissKeyboardOnTapOutside = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 16.sp),
                  enabled: enabled,
                  inputFormatters: [
                    // VinInputFormatter(), // Apply VIN validation
                    LengthLimitingTextInputFormatter(17), // Enforce max length
                    // UpperCaseTextFormatter(), // Convert to uppercase (standard for VIN)
                  ],
                  // Unfocus the field (hide keyboard) when tapping outside
                  onTapOutside: dismissKeyboardOnTapOutside ? (_) => FocusScope.of(context).unfocus() : null,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapIcon,
                child: SvgPicture.asset(
                  icon,
                  height: iconSize ?? 24.w,
                  width: iconSize ?? 24.w,
                ),
              ),
            ],
          ),
        ),
        if (isRequired)
          Positioned(
            top: 4.h,
            left: 4.w,
            child: Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

// Helper formatter to convert input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
