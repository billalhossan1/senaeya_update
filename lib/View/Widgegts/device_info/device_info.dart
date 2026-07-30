import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfo {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, String>> getDeviceDetails() async {
    String deviceId = '';
    String deviceType = '';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
      deviceType = 'Android';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? '';
      deviceType = 'iOS';
    } else {
      deviceType = 'Unknown';
      deviceId = 'N/A';
    }

    return {
      'deviceId': deviceId,
      'deviceType': deviceType,
    };
  }
}
