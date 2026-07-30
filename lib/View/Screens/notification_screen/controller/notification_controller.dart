import 'dart:convert';
import 'package:Senaeya/Service/socket_service.dart';
import 'package:Senaeya/Utils/AppLog/app_log.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/notification_screen/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Helper/shared_prefe/shared_prefe.dart';
import '../../home_screen/controller/home_controller.dart';
import '../repo/notification_repo.dart';

class NotificationController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getNotifications();
  }

  RxBool isLoading = false.obs;
  RxList<NotificationModel> notificationsList = <NotificationModel>[].obs;

  bool _socketRegistered = false;

  Future<void> getNotifications() async {
    isLoading.value = true;
    Response response = await NotificationRepo().getNotifications();
    isLoading.value = false;
    if (response.statusCode == 200) {
      NotificationModelResponse notificationModelResponse =
          NotificationModelResponse.fromJson(response.body);
      notificationsList
          .addAll(notificationModelResponse.data?.notificationList ?? []);
    } else {
      showCustomSnackBar(response.statusText ?? 'Unknown error occurred');
    }
  }

  /// Register socket listener for notifications for given userId
  void registerSocket(String userId) {
    try {
      if (_socketRegistered) return;
      if (userId.isEmpty) return;

      final eventName = 'notification::$userId';
      AppSocketAllOperation.instance.readEvent(
        event: eventName,
        handler: (data) async {
          try {
            appLog('NotificationController - socket event: $data');

            Map<String, dynamic>? payload;
            if (data == null) return;
            if (data is String) {
              try {
                payload = jsonDecode(data) as Map<String, dynamic>;
              } catch (e) {
                appLog('Failed to decode socket data as JSON: $e');
                return;
              }
            } else if (data is Map<String, dynamic>) {
              payload = data;
            } else if (data is Map) {
              payload = Map<String, dynamic>.from(data);
            } else {
              appLog('Unsupported socket payload type: ${data.runtimeType}');
              return;
            }

            // Map payload to NotificationModel; ensure createdAt is set
            NotificationModel notification;
            try {
              notification = NotificationModel.fromJson(payload);
            } catch (e) {
              // Fallback: construct manually
              notification = NotificationModel(
                title: payload['title']?.toString(),
                message: payload['message']?.toString(),
                messageAr: payload['message_ar']?.toString(),
                messageBn: payload['message_bn']?.toString(),
                messageTl: payload['message_tl']?.toString(),
                messageHi: payload['message_hi']?.toString(),
                messageUr: payload['message_ur']?.toString(),
                receiver: payload['receiver']?.toString(),
                type: payload['type']?.toString(),
                createdAt:
                    DateTime.tryParse(payload['createdAt']?.toString() ?? '')
                            ?.toUtc() ??
                        DateTime.now().toUtc(),
                read: false,
              );
            }

            // Ensure createdAt exists
            if (notification.createdAt == null) {
              notification.createdAt = DateTime.now().toUtc();
            }
            if (notification.presentDevice != null &&
                notification.presentDevice!.isNotEmpty) {
              String fcmToken = await SharePrefsHelper.getString(
                  SharedPreferenceValue.fcmToken);
              if (notification.presentDevice != fcmToken) {
                onLogOut();
                return;
              }
            }

            // Add to the top of the list
            notificationsList.insert(0, notification);

            // Optionally show a snackbar or toast
            try {
              if (notification.title != null && notification.message != null) {
                // showCustomSnackBar('${notification.title}: ${notification.message}', isError: false);
              } else if (notification.message != null) {
                // showCustomSnackBar(notification.message??'Something went wrong', isError: false);
              }
            } catch (e) {
              appLog('Error showing snackbar for notification: $e');
            }
          } catch (e) {
            appLog('Error handling notification socket event: $e');
          }
        },
      );

      _socketRegistered = true;
    } catch (e) {
      appLog('Failed to register notification socket: $e');
    }
  }

  Future<void> onLogOut() async {
    Get.delete<HomeController>();
    Get.deleteAll();
    await SharePrefsHelper.clearData();
    Navigator.pop(Get.context!);
    Get.offAllNamed(AppRoute.loginScreen);
  }
}
