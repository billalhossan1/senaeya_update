import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

import '../../Utils/AppColors/app_colors.dart';
import '../Widgegts/custom_text/custom_text.dart';

class CustomPhoneFieldWithButton extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String buttonText;
  final VoidCallback? onButtonTap;
  final ValueChanged<String>? onPhoneChanged;
  final ValueChanged<String>? onCountryChanged;
  final String initialCountryCode;
  final TextEditingController? controller;
  final bool isCountryCodeFixed;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool buttonEnabled;

  const CustomPhoneFieldWithButton({
    super.key,
    this.labelText,
    this.hintText = '',
    this.buttonText = 'check',
    this.onButtonTap,
    this.onPhoneChanged,
    this.onCountryChanged,
    this.initialCountryCode = 'SA',
    this.controller,
    this.isCountryCodeFixed = false,
    this.maxLength,
    this.validator,
    this.enabled = true,
    this.buttonEnabled = true,
  });

  @override
  State<CustomPhoneFieldWithButton> createState() =>
      _CustomPhoneFieldWithButtonState();
}

class _CustomPhoneFieldWithButtonState
    extends State<CustomPhoneFieldWithButton> {
  String? errorText;

  void _onChanged(phone) {
    final validator = widget.validator;
    final error = validator != null ? validator(phone) : null;
    setState(() {
      errorText = error;
    });
    if (widget.onPhoneChanged != null) {
      widget.onPhoneChanged!(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF4F5F7),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntlPhoneField(
                  controller: widget.controller,
                  initialCountryCode: widget.initialCountryCode,
                  showDropdownIcon: !widget.isCountryCodeFixed,
                  disableLengthCheck: widget.isCountryCodeFixed,
                  enabled: widget.enabled,
                  pickerDialogStyle: PickerDialogStyle(
                    searchFieldInputDecoration: InputDecoration(
                      hintText: 'Search Country/Region'.tr,

                    ),
                  ),
                  onChanged: (phone) => _onChanged(phone.completeNumber),
                  decoration: InputDecoration(
                    labelText: widget.labelText ?? 'phone_number'.tr,
                    hintText: widget.hintText,
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
                  dropdownDecoration: BoxDecoration(
                    color: AppColors.textFiledColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  inputFormatters: widget.maxLength != null
                      ? [LengthLimitingTextInputFormatter(widget.maxLength)]
                      : null,
                  onCountryChanged: widget.isCountryCodeFixed
                      ? (_) {}
                      : (country) {
                          // Call the callback when country changes
                          if (widget.onCountryChanged != null) {
                            widget.onCountryChanged!(country.code);
                          }
                        },
                ),
                if (errorText != null)
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 2.h),
                    child: Text(
                      errorText!,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 12.w,
          top: 0,
          bottom: 0,
          child: Center(
            child: GestureDetector(
              onTap: widget.buttonEnabled && widget.onButtonTap != null ? widget.onButtonTap : null,
              child: Container(
                width: 60.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: widget.buttonEnabled ? AppColors.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: CustomText(
                    text: widget.buttonText.tr,
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
