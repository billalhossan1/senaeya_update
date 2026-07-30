import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Helper/shared_prefe/shared_prefe.dart';
import 'package:Senaeya/Utils/AppLog/app_log.dart';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/auth_screens/repo/auth_repo.dart';
import 'package:Senaeya/View/Widgegts/device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:Senaeya/Utils/AppConst/app_const.dart';
import 'package:Senaeya/Service/api_client.dart';

import '../../../../Widgegts/custom_alert_dialog/custom_alert_dialog.dart';

class LoginScreenController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  final LocalAuthentication auth = LocalAuthentication();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool biometricAvailable = false.obs;

  void initial() async {
    biometricAvailable.value = await auth.isDeviceSupported();
  }

  @override
  void onInit() {
    // Ensure phoneController is initialized with '+9665'
    if (phoneController.text.isEmpty) {
      phoneController.text = '+9665';
    }
    initial();
    super.onInit();
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  String _normalizePhoneNumber(String value) {
    const arabicDigits = '٠١٢٣٤٥٦٧٨٩';
    const persianDigits = '۰۱۲۳۴۵۶۷۸۹';
    return value.split('').map((character) {
      final arabicIndex = arabicDigits.indexOf(character);
      if (arabicIndex >= 0) return arabicIndex.toString();
      final persianIndex = persianDigits.indexOf(character);
      if (persianIndex >= 0) return persianIndex.toString();
      return character;
    }).join();
  }

  void login() async {
    try {
      if (formKey.currentState!.validate()) {
        final deviceData = await DeviceInfo.getDeviceDetails();
        String deviceId = deviceData['deviceId']!;
        appLog("This is the Device Id : $deviceId");
        String deviceType = deviceData['deviceType']!;
        appLog("This is the Device Type : $deviceType");
        String fcmToken =
            await SharePrefsHelper.getString(SharedPreferenceValue.fcmToken);
        isLoading.value = true;

        Response response = await AuthRepo().login(
          fcmToken: fcmToken,
          // phone: "+8801939032974",
          phone: _normalizePhoneNumber(phoneController.text.trim()),
          password: passwordController.text,
          // password: "12182929",
          deviceId: deviceId,
          deviceType: deviceType,
        );

        isLoading.value = false;
        if (response.statusCode == 200) {
          String phone =
              await SharePrefsHelper.getString(SharedPreferenceValue.number);
          String password =
              await SharePrefsHelper.getString(SharedPreferenceValue.password);
          if (fingureSet && phone.isEmpty && password.isEmpty) {
            await setFingerPrint();
          }

          // Persist token and user/workshop ids BEFORE navigating.
          final String token = response.body['data']['accessToken'];
          final String userId = response.body['data']['userId'];
          if (response.body['data']['workshops'] != null &&
              response.body['data']['workshops'].isNotEmpty) {
            final String workShopId =
                response.body['data']['workshops'][0]["_id"];
            await SharePrefsHelper.setString(
              SharedPreferenceValue.workshopId,
              workShopId,
            );
          }

          final String role = response.body['data']['role'];

          // Await all writes so NavigationController / HomeController sees correct values
          await SharePrefsHelper.setString(SharedPreferenceValue.role, role);
          await SharePrefsHelper.setString(SharedPreferenceValue.token, token);
          await SharePrefsHelper.setString(AppConstants.bearerToken, token);
          await SharePrefsHelper.setString(
            SharedPreferenceValue.userId,
            userId,
          );

          // Set in-memory token to avoid race where ApiClient reads prefs before they're written
          ApiClient.bearerToken = token;

          // Suppress automatic logout redirect for a short period while initial requests complete
          ApiClient.suppressAutoLogoutFor(const Duration(seconds: 8));

          appLog('Saved token and ids. Navigating to nav screen.');

          // Now navigate
          loginSuccess();

          appLog(response.body);
        } else {
          if (Get.context != null) {
            showCustomSnackBar(response.statusText ?? "Error");
          } else {
            appLog('Error: ${response.statusText ?? "Error"}');
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      if (Get.context != null) {
        showCustomSnackBar(e.toString());
      } else {
        appLog('Error: $e');
      }
    }
  }

  bool fingureSet = false;
  void forgotPassword() {
    Get.toNamed(AppRoute.forgetScreen);
  }

  ///set Fingerprint
  Future<void> setFingerPrint() async {
    appLog('Fingerprint setup started');
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      appLog('Can check biometrics: $canCheckBiometrics');

      appLog('Is device supported: $biometricAvailable');
      if (!canCheckBiometrics || !biometricAvailable.value) {
        appLog('Biometric authentication not available on this device');
        showCustomSnackBar('biometric_error'.tr, isError: true);
        return;
      }

      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      appLog('Available biometrics: $availableBiometrics');

      // Check if any biometric is available
      if (availableBiometrics.isEmpty) {
        appLog('No biometrics enrolled');
        showCustomSnackBar('fingerprint_not_enrolled'.tr, isError: true);
        return;
      }

      // Separate try-catch for authentication to handle iOS cancellation gracefully
      bool authenticated = false;
      try {
        isLoading.value = true;
        authenticated = await auth.authenticate(
          localizedReason: 'authenticate_to_continue'.tr,
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: false,
          ),
        );
        appLog('Authenticated: $authenticated');
        isLoading.value = false;
      } catch (authError) {
        isLoading.value = false;
        appLog('Authentication dialog error: $authError');
        // Don't crash or show error if user cancelled (common on iOS)
        if (!authError.toString().toLowerCase().contains('cancel')) {
          showCustomSnackBar('authentication_error'.tr, isError: true);
        }
        return;
      }

      if (authenticated) {
        await SharePrefsHelper.setString(
            SharedPreferenceValue.number, phoneController.text.trim());
        await SharePrefsHelper.setString(
            SharedPreferenceValue.password, passwordController.text);
        showCustomSnackBar('fingerprint_set_successfully'.tr, isError: false);
        // Navigate to main screen instead of login screen to avoid duplicate GlobalKey error
        Get.offAllNamed(AppRoute.navScreen);
      } else {
        appLog('Fingerprint authentication failed');
        showCustomSnackBar('fingerprint_failed'.tr, isError: true);
      }
    } catch (e) {
      appLog('Authentication error: $e');
      isLoading.value = false;
      showCustomSnackBar(e.toString(), isError: true);
    }
    appLog('Fingerprint setup finished');
  }

  void loginSuccess() {
    CustomAlert.showInfo(
      context: Get.context!,
      message: 'login_successfully'.tr,
      onPressed: () {
        Get.back(); // Close the dialog only
        Get.offAllNamed(AppRoute.navScreen);
      },
    );
  }

  /// Fingerprint login
  Future<void> fingerprintLogin() async {
    fingureSet = true;

    String number = await SharePrefsHelper.getString(
      SharedPreferenceValue.number,
    );
    String password = await SharePrefsHelper.getString(
      SharedPreferenceValue.password,
    );
    if (number.isEmpty || password.isEmpty) {
      // Get.toNamed(AppRoute.loginWithPassword);
      if (Get.context != null) {
        showCustomSnackBar('You must log in first with your mobile number'.tr);
      }
      return;
    }
    appLog('Fingerprint login started');

    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      appLog('Can check biometrics: $canCheckBiometrics');

      appLog('Is device supported: $biometricAvailable');
      if (!canCheckBiometrics || !biometricAvailable.value) {
        appLog('Biometric authentication not available on this device');
        if (Get.context != null) {
          showCustomSnackBar('biometric_error'.tr, isError: true);
        }
        return;
      }

      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      appLog('Available biometrics: $availableBiometrics');

      if (availableBiometrics.isEmpty) {
        appLog('No biometrics enrolled');
        showCustomSnackBar('fingerprint_not_enrolled'.tr, isError: true);
        return;
      }

      // Get device data BEFORE authentication to avoid iOS state issues
      final deviceData = await DeviceInfo.getDeviceDetails();
      String deviceId = deviceData['deviceId']!;
      appLog("This is the Device Id : $deviceId");
      String deviceType = deviceData['deviceType']!;
      appLog("This is the Device Type : $deviceType");
      String fcmToken =
          await SharePrefsHelper.getString(SharedPreferenceValue.fcmToken);

      // Separate try-catch for authentication to handle iOS cancellation gracefully
      bool authenticated = false;
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'authenticate_to_continue'.tr,
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: false,
          ),
        );
        appLog('Authenticated: $authenticated');
      } catch (authError) {
        appLog('Authentication dialog error: $authError');
        // Don't crash or show error if user cancelled (common on iOS)
        if (!authError.toString().toLowerCase().contains('cancel')) {
          if (Get.context != null) {
            showCustomSnackBar('authentication_error'.tr, isError: true);
          }
        }
        return;
      }

      if (authenticated) {
        // Set loading ONLY after successful authentication
        isLoading.value = true;

        try {
          Response response = await AuthRepo().login(
            fcmToken: fcmToken,
            phone: number,
            password: password,
            deviceId: deviceId,
            deviceType: deviceType,
          );
          isLoading.value = false;

          if (response.statusCode == 200) {
            final String token = response.body['data']['accessToken'];
            if (response.body['data']['workshops'] != null &&
                response.body['data']['workshops'].isNotEmpty) {
              final String workShopId =
                  response.body['data']['workshops'][0]["_id"];
              await SharePrefsHelper.setString(
                SharedPreferenceValue.workshopId,
                workShopId,
              );
            }

            final String role = response.body['data']['role'];

            await SharePrefsHelper.setString(
                SharedPreferenceValue.token, token);
            await SharePrefsHelper.setString(SharedPreferenceValue.role, role);

            // set in-memory token and suppress auto-logout briefly
            ApiClient.bearerToken = token;
            ApiClient.suppressAutoLogoutFor(const Duration(seconds: 8));

            appLog('Saved token/workshopId for fingerprint login. Navigating.');

            loginSuccess();
          } else {
            if (Get.context != null) {
              showCustomSnackBar(response.statusText ?? "Error");
            }
          }
        } catch (loginError) {
          isLoading.value = false;
          appLog('Login error after authentication: $loginError');
          if (Get.context != null) {
            showCustomSnackBar('login_error'.tr, isError: true);
          }
        }
      } else {
        appLog('Fingerprint authentication failed');
        if (Get.context != null) {
          showCustomSnackBar('fingerprint_failed'.tr, isError: true);
        }
      }
    } catch (e) {
      appLog('Authentication error: $e');
      isLoading.value = false;
      if (Get.context != null) {
        showCustomSnackBar(e.toString(), isError: true);
      }
    }
    appLog('Fingerprint login finished');
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
