import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/AppColors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextStyle? style;
  final Color? fillColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final double? borderRadius;
  final FontWeight? fontWidth;
  final double? hintFontSize;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool obscureText;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  /// When true (default) the field will unfocus (hide keyboard) when the user
  /// taps outside the field (uses TextField/TextFormField's `onTapOutside`).
  /// You can set this to `false` to disable that behaviour for a particular
  /// instance.
  final bool dismissKeyboardOnTapOutside;

  const CustomTextField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    this.style,
    this.fillColor,
    this.hintTextColor,
    this.borderColor,
    this.borderRadius,
    this.hintFontSize,
    this.fontSize,
    this.contentPadding,
    this.height,
    this.controller,
    this.initialValue,
    this.fontWidth,
    this.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.center,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.dismissKeyboardOnTapOutside = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        enabled: enabled,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: readOnly,
        // If the SDK supports `onTapOutside` this will be invoked when the
        // user taps outside the field and will unfocus to hide the keyboard.
        // Keep it simple by providing an anonymous handler that calls
        // FocusScope.of(context).unfocus(). If the project's Flutter SDK is
        // old and doesn't have `onTapOutside`, this line may cause a build
        // error; if that happens we'll adapt to a fallback.
        onTapOutside: dismissKeyboardOnTapOutside ? (_) => FocusScope.of(context).unfocus() : null,
        decoration: InputDecoration(

          fillColor: fillColor ?? AppColors.textFiledColor,
          hintText: hintText,

          filled: true,
          hintStyle: TextStyle(

            color: hintTextColor ?? Colors.grey,
            fontSize: hintFontSize??14.sp,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColors.textFiledColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColors.textFiledColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColors.textFiledColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
          ),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIcon != null ? BoxConstraints(
            minWidth: 32.w,
            maxWidth: 32.w,
          ) : null,
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: style ??  TextStyle(fontSize: fontSize??14.sp,fontWeight: fontWidth??FontWeight.normal),
        maxLines: maxLines,
        obscureText: obscureText,
        textAlign: textAlign,
      ),
    );
  }
}
