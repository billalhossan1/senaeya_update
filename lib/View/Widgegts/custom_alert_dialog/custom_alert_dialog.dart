import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color? titleBackgroundColor;
  final Color? titleTextColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Widget? image; // optional image/widget to show above the message

  const CustomAlertDialog({
    Key? key,
    this.title = '',
    required this.message,
    this.buttonText,
    this.onPressed,
    this.titleBackgroundColor,
    this.titleTextColor,
    this.buttonColor,
    this.buttonTextColor,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 0.86.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title header
            if (title.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  color: titleBackgroundColor ?? const Color(0xFF1771B7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: CustomText(
                  text: title,
                  textAlign: TextAlign.center,
                  fontSize: 16.w,
                  fontWeight: FontWeight.bold,
                  color: titleTextColor ?? Colors.white,
                ),
              ),

            // Body
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (image != null) ...[
                    Center(child: image),
                    SizedBox(height: 12.h),
                  ],

                  CustomText(
                    text: message,
                    textAlign: TextAlign.center,
                    fontSize: 18.w,
                    color: Colors.black87,
                    overflow: TextOverflow.visible,
                  ),

                  SizedBox(height: 18.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed ?? () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor ?? const Color(0xFF1771B7),
                        foregroundColor: buttonTextColor ?? Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        elevation: 0,
                      ),
                      child: CustomText(
                        text: buttonText ?? 'OK'.tr,
                        fontSize: 18.sp,
                        color: buttonTextColor ?? Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class for easy usage
class CustomAlert {
  static void show({
    required BuildContext context,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    String title = '',
    Color? titleBackgroundColor,
    Color? titleTextColor,
    Color? buttonColor,
    Color? buttonTextColor,
    Widget? image,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          message: message,
          title: title,
          buttonText: buttonText,
          onPressed: onPressed,
          titleBackgroundColor: titleBackgroundColor,
          titleTextColor: titleTextColor,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          image: image,
        );
      },
    );
  }

  // Predefined alert types
  static void showInfo({
    required BuildContext context,
    required String message,
    String title = '',
    String? buttonText,
    VoidCallback? onPressed,
    Widget? image,
  }) {
    show(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      titleBackgroundColor: const Color(0xFF1771B7),
      image: image,
    );
  }

  static void showError({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    Widget? image,
  }) {
    show(
      context: context,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      titleBackgroundColor: AppColors.red,
      buttonColor: AppColors.red,
      image: image,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    Widget? image,
  }) {
    show(
      context: context,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      titleBackgroundColor: Colors.orange,
      buttonColor: Colors.orange,
      image: image,
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    Widget? image,
  }) {
    show(
      context: context,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      titleBackgroundColor: Colors.green,
      buttonColor: Colors.green,
      image: image,
    );
  }

  // Two button dialog with Yes/No options
  static void showConfirmation({
    required BuildContext context,
    required String message,
    String title = '',
    String? yesButtonText,
    String? noButtonText,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    Color? titleBackgroundColor,
    Color? titleTextColor,
    Widget? image,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 0.8.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title header
                  if (title.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: titleBackgroundColor ?? const Color(0xFF1771B7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      child: CustomText(
                        text: title,
                        textAlign: TextAlign.center,
                        fontSize: 16.w,
                        fontWeight: FontWeight.bold,
                        color: titleTextColor ?? Colors.white,
                        overflow: TextOverflow.visible,
                      ),
                    ),

                  // Message content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      children: [
                        if (image != null) ...[
                          Center(child: image),
                          SizedBox(height: 12.h),
                        ],

                        CustomText(
                          text: message,
                          textAlign: TextAlign.center,
                          fontSize: 18.w,
                          color: Colors.black87,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),

                  // Buttons Row
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: Row(
                      children: [
                        // No Button with Red Gradient
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFAECEC),
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: ElevatedButton(
                              onPressed: onNoPressed ?? () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                elevation: 0,
                              ),
                              child: CustomText(
                                text: noButtonText ?? 'No'.tr,
                                fontSize: 16.w,
                                color: AppColors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onYesPressed ?? () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1771B7),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              elevation: 0,
                            ),
                            child: CustomText(
                              text: yesButtonText ?? 'Yes'.tr,
                              fontSize: 16.w,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showConfirmationColumn({
    required BuildContext context,
    required String message,
    String? message1,
    String? title,
    String? yesButtonText,
    String? noButtonText,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    Color? titleBackgroundColor,
    Color? titleTextColor,
    Widget? image,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 0.8.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  // Title header
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: title,
                        textAlign: TextAlign.center,
                        fontSize: 16.w,
                        fontWeight: FontWeight.bold,
                        color: titleTextColor ?? Colors.black,
                      ),
                    ),

                  // Message content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      children: [
                        if (image != null) ...[
                          Center(child: image),
                          SizedBox(height: 12.h),
                        ],
                        if (message1 != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CustomText(
                              text: message1,
                              textAlign: TextAlign.center,
                              fontSize: 18.w,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        CustomText(
                          text: message,
                          textAlign: TextAlign.center,
                          fontSize: 16.w,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),

                  // Buttons Row
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: Column(
                      children: [
                        // Yes Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onYesPressed ?? () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1771B7),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              elevation: 0,
                            ),
                            child: CustomText(
                              text: yesButtonText ?? 'Yes'.tr,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // No Button with light red background
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFAECEC),
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: ElevatedButton(
                              onPressed: onNoPressed ?? () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: AppColors.red,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                elevation: 0,
                              ),
                              child: CustomText(
                                text: noButtonText ?? 'No'.tr,
                                fontSize: 18.sp,
                                color: AppColors.red,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Yes/No dialog with both buttons visible at the same time (side by side)
  static void showYesNoDialogSimultaneous({
    required BuildContext context,
    required String message,
    String title = '',
    String? yesButtonText,
    String? noButtonText,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    Color? titleBackgroundColor,
    Color? titleTextColor,
    Color? yesButtonColor,
    Color? noButtonColor,
    Color? yesButtonTextColor,
    Color? noButtonTextColor,
    Widget? image,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 0.8.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: titleBackgroundColor ?? const Color(0xFF1771B7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      child: CustomText(
                        text: title,
                        textAlign: TextAlign.center,
                        fontSize: 24.w,
                        fontWeight: FontWeight.bold,
                        color: titleTextColor ?? Colors.white,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      children: [
                        if (image != null) ...[
                          Center(child: image),
                          SizedBox(height: 12.h),
                        ],
                        CustomText(
                          text: message,
                          textAlign: TextAlign.center,
                          fontSize: 22.w,
                          color: Colors.black87,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  // Buttons Row (side by side)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: Row(
                      children: [
                        // No Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (onNoPressed != null) {
                                onNoPressed();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: noButtonColor ?? AppColors.redTextFiled,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.h),
                                child: CustomText(
                                  text: noButtonText ?? 'No'.tr,
                                  color: noButtonTextColor ?? AppColors.red,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Yes Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (onYesPressed != null) {
                                onYesPressed();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: yesButtonColor ?? AppColors.primary,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.h),
                                child: CustomText(
                                  text: yesButtonText ?? 'Yes'.tr,
                                  color: yesButtonTextColor ?? Colors.white,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Usage Examples:
/*

// Basic usage with CustomAlert helper class:
CustomAlert.showInfo(
  context: context,
  title: 'Check',
  message: 'This vehicle is unregistered\nPlease enter vehicle information',
);

// Error alert:
CustomAlert.showError(
  context: context,
  title: 'Error',
  message: 'Something went wrong. Please try again.',
);

// Custom colors:
CustomAlert.show(
  context: context,
  title: 'Custom Alert',
  message: 'This is a custom styled alert',
  buttonText: 'Got it',
  titleBackgroundColor: Colors.purple,
  buttonColor: Colors.purple,
  onPressed: () {
    Navigator.of(context).pop();
    // Do something after dismissing
  },
};

// Direct widget usage:
showDialog(
  context: context,
  builder: (context) => CustomAlertDialog(
    title: 'Check',
    message: 'This vehicle is unregistered\nPlease enter vehicle information',
    onPressed: () {
      Navigator.of(context).pop();
      // Handle OK button press
    },
  ),
);

*/
