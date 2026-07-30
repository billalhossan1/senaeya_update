import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../Widgegts/custom_text/custom_text.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWithButton extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String buttonText;
  final VoidCallback onButtonTap;
  final ValueChanged<String>? onTextChanged;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool enabled;
  final String? prefix;
  final String? Function(String?)? validator;

  const CustomTextFieldWithButton({
    super.key,
    this.labelText,
    this.hintText = '',
    this.buttonText = 'check',
    required this.onButtonTap,
    this.onTextChanged,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.prefix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize controller with prefix (if empty)
    if (prefix != null &&
        prefix!.isNotEmpty &&
        controller != null &&
        controller!.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller!.text.isEmpty) {
          controller!.text = prefix!;
          controller!.selection = TextSelection.fromPosition(
            TextPosition(offset: controller!.text.length),
          );
        }
      });
    }

    // ✅ Build input formatters (IMPORTANT)
    List<TextInputFormatter> formatters = [];

    if (prefix != null && prefix!.isNotEmpty) {
      formatters.add(_PrefixTextInputFormatter(prefix!));
      formatters.add(LengthLimitingTextInputFormatter(prefix!.length + 8));
    } else {
      formatters.add(LengthLimitingTextInputFormatter(14));
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF4F5F7),
            borderRadius: BorderRadius.circular(24.r),
          ),

          child: TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            onChanged: onTextChanged,
            validator: validator,
            inputFormatters: formatters,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: AppColors.textFiledColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
              counterText: '',
              contentPadding: EdgeInsets.only(
                left: 16.w,
                right: 80.w,
                top: 16.h,
                bottom: 16.h,
              ),
            ),
          ),
        ),

        // Right-side button
        Positioned(
          right: 12.w,
          top: 0,
          bottom: 0,
          child: Center(
            child: GestureDetector(
              onTap: onButtonTap,
              child: Container(
                width: 60.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: CustomText(
                    text: buttonText.tr,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------------------
//  Prefix Input Formatter
// ----------------------------------------------------------

class _PrefixTextInputFormatter extends TextInputFormatter {
  final String prefix;

  _PrefixTextInputFormatter(this.prefix);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    // Prevent deleting prefix
    if (newValue.text.isEmpty || newValue.text.length < prefix.length) {
      return TextEditingValue(
        text: prefix,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }

    // Ensure prefix always stays
    if (!newValue.text.startsWith(prefix)) {
      String userInput = newValue.text.replaceAll(prefix, '');
      return TextEditingValue(
        text: prefix + userInput,
        selection: TextSelection.collapsed(
          offset: prefix.length + userInput.length,
        ),
      );
    }

    // Prevent cursor before prefix
    if (newValue.selection.baseOffset < prefix.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }

    return newValue;
  }
}
