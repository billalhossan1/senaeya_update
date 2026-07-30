import 'package:Senaeya/View/Widgegts/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import '../../../Utils/AppColors/app_colors.dart';
import 'verification_controller.dart';

class CustomAlertVerificationDialog extends StatelessWidget {
  final TextEditingController? otpContrller;
  final String? phoneNumber;
  final Function(String)? onVerificationComplete;
  final VoidCallback? onResendCode;

  const CustomAlertVerificationDialog({
    super.key,
    this.phoneNumber,
    this.onVerificationComplete,
    this.onResendCode,
    this.otpContrller,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                 CustomText(
                  text: 'OTP Code'.tr,
                  fontSize: 20,
                  color: Colors.black,
                ),
                const SizedBox(height: 16),

                // Description
                CustomText(
                  text:
                      'Enter the activation code sent to\nthe customer\'s mobile via WhatsApp'.tr,
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  color: Colors.grey[600]!,
                ),
                const SizedBox(height: 32),

                // Pin Code Field
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.grey[100],
                    selectedFillColor: Colors.white,
                    activeColor: AppColors.primary,
                    inactiveColor: Colors.grey[300],
                    selectedColor: AppColors.primary,
                    borderWidth: 2,
                  ),
                  controller: otpContrller,
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (value) {
                    controller.completeCode(value);
                  },
                  onChanged: (value) {
                    controller.updateCode(value);
                  },
                ),
                const SizedBox(height: 32),

                // Activation Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isCodeComplete
                          ? () {
                              if (onVerificationComplete != null) {
                                onVerificationComplete!(
                                  controller.currentText.value,
                                );
                              }

                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child:  CustomText(
                        text: 'activation'.tr,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Problem and Resend Section
                 CustomText(
                  text: 'You have a problem?'.tr,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                const SizedBox(height: 8),

                // Countdown and Resend
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.formatTime(controller.countdown.value),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: controller.canResend
                            ? () {
                                if (onResendCode != null) {
                                  onResendCode!();
                                }
                                controller.startCountdown();
                              }
                            : null,
                        child: CustomText(
                          text: 'Resend the code'.tr,
                          fontSize: 14,
                          color: controller.canResend
                              ? AppColors.red
                              : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
