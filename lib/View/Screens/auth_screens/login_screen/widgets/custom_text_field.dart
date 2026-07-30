import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/View/Widgets/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Widgegts/custom_button/custom_button.dart';
import '../../../../Widgegts/custom_text/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? icon;
  final Color? color;
  final bool obscureText;
  final InputDecoration? inputDecoration;
  final bool showOneStar;
  final bool showTwoStar;
  final bool showCheckButton;
  final VoidCallback? onTapCheck;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool centerHintText;
  final bool isRightStar;
  final String? Function(String?)? validator;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? prefix;
  final int? maxDigits; // ✅ Added new field for max digits
  final double? fontSize; // Font size for input text
  /// When true (default) the field will unfocus (hide keyboard) when the user
  /// taps outside the field (uses TextFormField.onTapOutside).
  final bool dismissKeyboardOnTapOutside;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.color,
    required this.hintText,
    this.icon,
    this.showOneStar = false,
    this.showTwoStar = false,
    this.dismissKeyboardOnTapOutside = true,
    this.onTapCheck,
    this.obscureText = false,
    this.showCheckButton = false,
    this.keyboardType = TextInputType.text,
    this.maxLines,
    this.inputDecoration,
    this.centerHintText = false,
    this.isRightStar = true,
    this.validator,
    this.readOnly = false,
    this.inputFormatters,
    this.onChanged,
    this.prefix,
    this.maxDigits, // ✅ Added to constructor
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    if (prefix != null && prefix!.isNotEmpty && controller.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.text.isEmpty) {
          controller.text = prefix!;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
      });
    }

    String? Function(String?)? effectiveValidator = validator;
    if (validator == null) {
      if (keyboardType == TextInputType.emailAddress) {
        effectiveValidator = (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Email is required';
          }
          final emailRegex = RegExp(r'^[\w-.]+@[\w-]+\.[a-zA-Z]{2,}$');
          if (!emailRegex.hasMatch(value.trim())) {
            return 'Enter a valid email';
          }
          return null;
        };
      } else {
        effectiveValidator = (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        };
      }
    }

    List<TextInputFormatter>? effectiveFormatters =
    inputFormatters != null ? List.from(inputFormatters!) : [];

    if (prefix != null && prefix!.isNotEmpty) {
      effectiveFormatters.insert(0, _PrefixTextInputFormatter(prefix!));
    }

    // ✅ Apply max length formatter if maxDigits is provided
    if (maxDigits != null && maxDigits! > 0) {
      effectiveFormatters.add(LengthLimitingTextInputFormatter(maxDigits));
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: readOnly
            ? Colors.grey.shade200
            : (color ?? AppColors.textFiledColor),
        borderRadius: BorderRadius.circular(30.r),
        border:
        readOnly ? Border.all(color: Colors.grey.shade400, width: 1) : null,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null && icon!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 18.h),
                  child: SvgPicture.asset(icon!, width: 20.w, height: 20.h),
                ),
              Expanded(
                child: TextFormField(

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller,
                  obscureText: obscureText,
                  readOnly: readOnly,
                  keyboardType: keyboardType,
                  inputFormatters:
                  effectiveFormatters.isNotEmpty ? effectiveFormatters : null,
                  // If available, this will unfocus the field when tapping outside
                  // (hiding the keyboard). Set dismissKeyboardOnTapOutside to
                  // false to disable for a particular instance.
                  onTapOutside: dismissKeyboardOnTapOutside ? (_) => FocusScope.of(context).unfocus() : null,
                  style: customTextStyle(
                    fontSize: fontSize ?? 14.sp,
                    fontWeight: FontWeight.w400,
                    color: readOnly ? Colors.grey.shade600 : Colors.black,
                  ),
                  textAlign: centerHintText
                      ? TextAlign.center
                      : (isRTL ? TextAlign.right : TextAlign.left),
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: maxLines ?? 1,
                  decoration: inputDecoration ??
                      InputDecoration(
                        hintText: hintText,
                        hintTextDirection:
                        isRTL ? TextDirection.rtl : TextDirection.ltr,
                        hintStyle: centerHintText
                            ? TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          textBaseline: TextBaseline.alphabetic,
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: centerHintText
                            ? EdgeInsets.symmetric(vertical: 18.h)
                            : EdgeInsetsDirectional.symmetric(
                            vertical: 18.h, horizontal: 16.w),
                      ),
                  validator: effectiveValidator,
                  onChanged: onChanged,
                ),
              ),
              if (showCheckButton)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 8),
                  child: CustomButtonPrev(
                    title: 'check'.tr,
                    height: 36.h,
                    width: 80.w,
                    onTap: () => onTapCheck?.call(),
                    fillColor: const Color(0xFF0C5CA8),
                    textColor: Colors.white,
                  ),
                ),
            ],
          ),
          if (showOneStar || showTwoStar)
            Positioned(
              top: 4.h,
              right: isRightStar ? 16.w : null,
              left: isRightStar ? null : 16.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showOneStar)
                    const CustomText(
                      text: "*",
                      color: AppColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  if (showTwoStar)
                    const CustomText(
                      text: "**",
                      color: AppColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// TextInputFormatter to enforce non-editable prefix
class _PrefixTextInputFormatter extends TextInputFormatter {
  final String prefix;

  _PrefixTextInputFormatter(this.prefix);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty || newValue.text.length < prefix.length) {
      return TextEditingValue(
        text: prefix,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }

    if (!newValue.text.startsWith(prefix)) {
      if (newValue.text.length < oldValue.text.length) {
        return oldValue;
      }

      String userInput = newValue.text.replaceAll(prefix, '');

      return TextEditingValue(
        text: prefix + userInput,
        selection:
        TextSelection.collapsed(offset: prefix.length + userInput.length),
      );
    }

    if (newValue.selection.baseOffset < prefix.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }

    return newValue;
  }
}
