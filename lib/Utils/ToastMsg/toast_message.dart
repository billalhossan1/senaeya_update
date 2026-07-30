import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

OverlayEntry? _currentOverlay;
OverlayState? _overlayState;

/// Shows a custom message from the top of the screen
void showCustomSnackBar(String message, {bool isError = true}) {
  if (message.isEmpty) return;

  try {
    // Remove existing overlay if present
    _removeCurrentOverlay();

    // Get the navigator's overlay
    final NavigatorState? navigator = Get.key.currentState;
    if (navigator == null) {
      print('Navigator not available');
      return;
    }

    _overlayState = navigator.overlay;
    if (_overlayState == null) {
      print('Overlay state not available');
      return;
    }

    final overlay = OverlayEntry(
      builder: (context) => _TopSnackBar(
        message: message,
        isError: isError,
        onDismiss: _removeCurrentOverlay,
      ),
    );

    _currentOverlay = overlay;
    _overlayState!.insert(overlay);

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), _removeCurrentOverlay);
  } catch (e) {
    print('Error showing snackbar: $e');
  }
}

void _removeCurrentOverlay() {
  try {
    _currentOverlay?.remove();
    _currentOverlay = null;
    _overlayState = null;
  } catch (e) {
    print('Error removing overlay: $e');
  }
}

/// Convenience function for success messages
void showToast(String message) {
  showCustomSnackBar(message, isError: false);
}

class _TopSnackBar extends StatefulWidget {
  final String message;
  final bool isError;
  final VoidCallback onDismiss;

  const _TopSnackBar({
    required this.message,
    required this.isError,
    required this.onDismiss,
  });

  @override
  State<_TopSnackBar> createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<_TopSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 10.h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy < -5) {
                widget.onDismiss();
              }
            },
            child: Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: widget.isError ? Colors.red.shade600 : Colors.green.shade600,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    widget.isError ? Icons.error_outline : Icons.check_circle_outline,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isError ? "Error".tr : "Success".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onDismiss,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
//
//
// void showCustomSnackBar(String? message,
//     {bool isError = true, bool getXSnackBar = false}) {
//   if (message != null && message.isNotEmpty) {
//     final context = Get.context;
//     if (context != null) {
//       final snackBar = SnackBar(
//         elevation: 0,
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.transparent,
//         margin: EdgeInsets.only(
//           left: 10.sp,
//           right: 10.sp,
//           top: 40.sp,
//           bottom: 0,
//         ),
//         content: AwesomeSnackbarContent(
//           title: isError ? "Failed" : "Success",
//           message: message,
//           contentType: isError
//               ? ContentType.failure
//               : ContentType.success,
//         ),
//       );
//
//       ScaffoldMessenger.of(context)
//         ..hideCurrentSnackBar()
//         ..showSnackBar(snackBar);
//     }
//   }
// }
//
// void toastMessage({required String message}) {
//   showCustomSnackBar(message, isError: false, getXSnackBar: true);
// }
