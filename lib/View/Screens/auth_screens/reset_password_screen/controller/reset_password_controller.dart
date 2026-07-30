import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;


  void onTapForgotPassword() {
    Get.toNamed(AppRoute.otpVerificationScreen);
  }
  void initial(){
    newPasswordController= TextEditingController();
    confirmPasswordController= TextEditingController();
  }
  @override
  void onInit() {
    initial();
    super.onInit();
  }
  void onTapResetPassword() async {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      showCustomSnackBar('reset_password_fill_fields'.tr, isError: true);
      return;
    }
    if (newPassword != confirmPassword) {
      showCustomSnackBar('reset_password_passwords_not_match'.tr, isError: true);
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    showCustomSnackBar('reset_password_success'.tr, isError: false);
    Get.toNamed(AppRoute.loginScreen);
    // You can add navigation or further logic here
  }

  @override
  void onClose() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    super.onClose();
  }
}
