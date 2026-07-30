import 'dart:io';
import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

enum PermissionRequestResult { granted, denied, permanentlyDenied }

class DownloadRepository {
  // Method to download PDF
  Future<void> downloadPDF(
      String pdfUrl,
      {
        required  String name,
        required  String folderName,
        required Function setInProgress,
        required Function setErrorMessage,
      }) async {
    try {
      setInProgress(true);

      // Check if the URL is valid
      if (pdfUrl.isEmpty) {
        setErrorMessage('PDF URL is empty.');
        setInProgress(false);
        return;
      }

      // Request storage permission only on Android
      if (Platform.isAndroid) {
        final permissionResult = await _requestPermissions();
        if (permissionResult == PermissionRequestResult.denied) {
          setInProgress(false);
          setErrorMessage('Permission denied. Please allow access to storage to download PDF.');
          showCustomSnackBar('Permission denied. Please allow access to storage to download PDF.',isError: true);

          return;
        } else if (permissionResult == PermissionRequestResult.permanentlyDenied) {
          setInProgress(false);
          _showPermissionSettingsBottomSheet();
          return;
        }
      }

      // Get the appropriate download directory for the platform
      Directory downloadDir = await _getDownloadDirectory(folderName);
      print("==================\u001b[32m");
      // Specify the file path for the downloaded PDF
      String filePath = "${downloadDir.path}/$name";
      Logger().i('Saving PDF to: $filePath');
      // Download the file using Dio
      Dio dio = Dio();
      await dio.download(pdfUrl, filePath);

      // Notify that download is complete
      setInProgress(false);
      showCustomSnackBar( 'PDF downloaded successfully!'.tr,isError: false);

    } catch (e) {
      setInProgress(false);
      setErrorMessage('Failed to download PDF: $e');
      showCustomSnackBar('Download Failed'.tr,isError: true);
    }
  }

  // Get the public Downloads directory path (Android) or Documents/folderName (iOS)
  Future<Directory> _getDownloadDirectory(String folderName) async {
    Directory? baseDir;
    if (Platform.isAndroid) {
      baseDir = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      baseDir = await getApplicationDocumentsDirectory();
    }
    if (baseDir == null) {
      throw 'Unable to get download directory';
    }
    // Create subfolder if folderName is provided
    final Directory targetDir = Directory('${baseDir.path}/$folderName');
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true);
    }
    return targetDir;
  }

  // Request storage permission (Android only)
  Future<PermissionRequestResult> _requestPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        // Only request storage permission for Android < 13
        if (await Permission.storage.isGranted) {
          return PermissionRequestResult.granted;
        }
        var status = await Permission.storage.status;
        if (status.isPermanentlyDenied) {
          return PermissionRequestResult.permanentlyDenied;
        }
        if (status.isDenied) {
          status = await Permission.storage.request();
        }
        if (status.isGranted) return PermissionRequestResult.granted;
        if (status.isPermanentlyDenied) return PermissionRequestResult.permanentlyDenied;
        return PermissionRequestResult.denied;
      } else {
        // Android 13+ (API 33+) - no storage permission needed for app-private directories
        return PermissionRequestResult.granted;
      }
    }
    // On iOS, no permission is needed to save to app's Documents directory
    return PermissionRequestResult.granted;
  }

  void _showPermissionSettingsBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Permission Required',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You have permanently denied access to storage. Please open settings and allow permission to download PDF.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(Get.context!);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                    Get.back();
                  },
                  child: const Text('Open Settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
