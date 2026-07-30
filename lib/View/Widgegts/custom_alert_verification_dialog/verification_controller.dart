import 'dart:async';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final RxString currentText = ''.obs;
  final RxBool hasError = false.obs;
  final RxInt countdown = 120.obs; // 2 minutes countdown
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startCountdown() {
    _timer?.cancel();
    countdown.value = 120;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void updateCode(String value) {
    currentText.value = value;
    hasError.value = false;
  }

  void completeCode(String value) {
    currentText.value = value;
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool get isCodeComplete => currentText.value.length == 4;
  bool get canResend => countdown.value <= 0;
}
