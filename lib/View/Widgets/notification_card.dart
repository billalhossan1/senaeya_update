import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Screens/notification_screen/model/notification_model.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    // Convert to GMT+3
    final gmt3Date = date.toUtc().add(const Duration(hours: 3));

    return DateFormat('hh:mm a yyyy-MM-dd').format(gmt3Date);
  }

  String _getLocalizedMessage(NotificationModel notification) {
    final locale = Get.locale?.languageCode ?? 'en';
    String? msg;

    switch (locale) {
      case 'ar':
        msg = notification.messageAr;
        break;
      case 'bn':
        msg = notification.messageBn;
        break;
      case 'hi':
        msg = notification.messageHi;
        break;
      case 'fil': // Using 'fil' as used in AppTranslations
        msg = notification.messageTl;
        break;
      case 'ur':
        msg = notification.messageUr;
        break;
      default:
        msg = notification.message;
    }

    // Fallback if specific language message is empty
    if (msg == null || msg.isEmpty || msg == "null") {
      msg = notification.message;
    }

    return msg ?? "No message";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            constraints: BoxConstraints(
              minHeight: 70.h,
            ),
            decoration: BoxDecoration(
              color: notification.read == true
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFFE8F1F8),
              borderRadius: BorderRadius.circular(10.r),
            ),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppIcon.notification2,
                        height: 24.w,
                        width: 24.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomText(
                      textAlign: TextAlign.start,
                      text: _getLocalizedMessage(notification),
                      overflow: TextOverflow.visible,
                      fontSize: 12,
                      minFontSize: 10,
                      fontWeight: FontWeight.w400,
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
          bottom: 4.h,
          left: 66.w,
          child: CustomText(
            text: _formatDate(notification.createdAt),
            fontSize: 8,
            minFontSize: 6,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
