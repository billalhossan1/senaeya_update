import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OtpVerificationController extends GetxController {
  late TextEditingController otpController;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  // Timer logic
  var secondsRemaining = 60.obs;
  var isTimerRunning = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    initial();
  }

  void initial(){
    otpController = TextEditingController();
    startTimer();
  }

  void startTimer() {
    isTimerRunning.value = true;
    secondsRemaining.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isTimerRunning.value = false;
        _timer?.cancel();
      }
    });
  }

  void resendOtp() async {
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';
    isLoading.value = false;
    successMessage.value = 'otp_resent_success'.tr;
    startTimer();
  }

  void resetPassword() async {
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';
    await Future.delayed(const Duration(seconds: 2)); // Simulate network call
    isLoading.value = false;
    successMessage.value = 'password_reset_success'.tr;
    // You can add navigation or further logic here
  }

  void verifyOtp() async {
    final otp = otpController.text.trim();
    errorMessage.value = '';
    successMessage.value = '';
    if (!_validateOtp(otp)) {
      errorMessage.value = 'otp_invalid_code'.tr;
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate network call
    isLoading.value = false;
    if (otp == '1234') { // Example correct OTP
      successMessage.value = 'otp_verified_success'.tr;
      Get.toNamed(AppRoute.resetPasswordScreen);
    } else {
      errorMessage.value = 'otp_invalid'.tr;
    }
  }
  //test

  bool _validateOtp(String otp) {
    return otp.length == 4 && int.tryParse(otp) != null;
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.clear();
    super.onClose();
  }
}