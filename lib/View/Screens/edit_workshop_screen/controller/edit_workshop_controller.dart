import 'package:Senaeya/Utils/ToastMsg/toast_message.dart';
import 'package:Senaeya/View/Screens/home_screen/controller/home_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Widgegts/map_location_picker_dialog/map_location_picker_dialog.dart';
import '../repo/edit_workshop_screen_repo.dart';

class EditWorkshopController extends GetxController {
  GlobalKey<FormState>formKey = GlobalKey<FormState>();
  final EditWorkshopScreenRepo _repo = EditWorkshopScreenRepo();
  // Text controllers for all fields
  final workshopNameController = TextEditingController();
  final workshopNameArabicController = TextEditingController();
  final workshopContact = TextEditingController();
  final nationalNumberController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final addressController = TextEditingController();
  final taxNumberController = TextEditingController();
  final ibanController = TextEditingController();
  RxBool isLoading = false.obs;
  // Checkbox for mobile workshop
  var isMobileWorkshop = false.obs;

  // Working hours
  var regularDayFrom = 'sunday'.obs;
  var regularDayTo = 'friday'.obs;
  var regularFrom = const TimeOfDay(hour: 8, minute: 0).obs;
  var regularTo = const TimeOfDay(hour: 18, minute: 0).obs;

  var ramadanDayFrom = 'sunday'.obs;
  var ramadanDayTo = 'thursday'.obs;
  var ramadanFrom = const TimeOfDay(hour: 14, minute: 0).obs;
  var ramadanTo = const TimeOfDay(hour: 21, minute: 0).obs;

  // Location
  var isLocationAdded = false.obs;
  LatLng? selectedLocation;
  var locationAddress = ''.obs;

  // Validation
  RxBool isFormValid = false.obs;

  void validateForm() {
    isFormValid.value =
        workshopNameController.text.isNotEmpty &&
        workshopNameArabicController.text.isNotEmpty &&
        nationalNumberController.text.isNotEmpty &&
        registrationNumberController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
  }

  void onTapSubmit() {
    validateForm();
    // Use a safe null-aware call to avoid crashing when the Form isn't mounted yet.
    final formValid = formKey.currentState?.validate() ?? true;
    if (isFormValid.value && formValid) {
      submit();
    } else {
      showCustomSnackBar("please_fill_all_required_fields".tr, isError: true);
    }
  }

  // Add workshop location
  Future<void> addLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showCustomSnackBar('location_services_disabled'.tr, isError: true);
      return;
    }

    // Request location permission
    PermissionStatus permission = await Permission.location.status;

    if (permission.isDenied) {
      permission = await Permission.location.request();
    }

    if (permission.isDenied) {
      showCustomSnackBar('location_permission_required'.tr, isError: true);
      return;
    }

    if (permission.isPermanentlyDenied) {
      showCustomSnackBar(
        'location_permission_permanently_denied'.tr,
        isError: true,
      );
      await openAppSettings();
      return;
    }

    // Permission granted, show map dialog
    Get.dialog(
      MapLocationPickerDialog(
        initialLocation: selectedLocation,
        onLocationSelected: (location, address) {
          selectedLocation = location;
          locationAddress.value = address;
          isLocationAdded.value = true;
          showCustomSnackBar('location_selected_successfully'.tr);
        },
      ),
    );
  }

  // Submit
  Future<void> submit() async {
    if (selectedLocation == null) {
      showCustomSnackBar('please_add_workshop_location'.tr, isError: true);
      return;
    }

    isLoading.value = true;

    try {
      // Prepare workshop location data
      Map<String, dynamic> workshopGEOlocation = {
        "type": "Point",
        "coordinates": [
          selectedLocation!.longitude, // ← longitude comes FIRST
          selectedLocation!.latitude, // ← latitude comes SECOND
        ],
      };

      // Prepare regular working schedule
      Map<String, dynamic> regularWorkingSchedule = {
        "startDay": regularDayFrom.value.capitalize,
        "endDay": regularDayTo.value.capitalize,
        "startTime": _formatTime(regularFrom.value),
        "endTime": _formatTime(regularTo.value),
      };

      // Prepare ramadan working schedule
      Map<String, dynamic> ramadanWorkingSchedule = {
        "startDay": ramadanDayFrom.value.capitalize,
        "endDay": ramadanDayTo.value.capitalize,
        "startTime": _formatTime(ramadanFrom.value),
        "endTime": _formatTime(ramadanTo.value),
      };

      // Build fields safely: don't send empty/placeholder IBAN or empty tax number
      final bankAccText = ibanController.text.trim();
      // Repo expects a non-null String for bankAccountNumber; send empty string when no real IBAN provided.
      final bankAccountToSend = (bankAccText.isEmpty || bankAccText.toUpperCase() == 'SA')
          ? ''
          : bankAccText;

      final taxText = taxNumberController.text.trim();
      final taxToSend = (taxFromApi.isEmpty && taxText.isNotEmpty) ? taxText : null;

      // Call API - only send editable fields
      final response = await _repo.updateWorkshop(
        workshopNameEnglish: workshopNameController.text.trim(),
        contact: workshopContact.text.trim(),
        address: addressController.text.trim(),
        isAvailableMobileWorkshop: isMobileWorkshop.value,
        workshopGEOlocation: workshopGEOlocation,
        regularWorkingSchedule: regularWorkingSchedule,
        ramadanWorkingSchedule: ramadanWorkingSchedule,
        taxVatNumber: taxToSend,
        bankAccountNumber: bankAccountToSend,
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        HomeController homeController = Get.find<HomeController>();
        homeController.workShopName.value=  workshopNameController.text.trim();
        Navigator.pop(Get.context!);
        showCustomSnackBar('workshop_updated_successfully'.tr,isError: false);



      } else {
        showCustomSnackBar(
          response.statusText ?? 'failed_to_update_workshop'.tr,
          isError: true,
        );
      }
    } catch (e) {
      isLoading.value = false;
      showCustomSnackBar('error_occurred'.tr, isError: true);
      debugPrint('Error updating workshop: $e');
    }
  }

  // Helper method to format time
  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize IBAN with "SA" prefix so the prefix always appears when empty
    ibanController.text = 'SA';
    ibanController.selection = TextSelection.fromPosition(
      TextPosition(offset: ibanController.text.length),
    );
    workshopNameController.addListener(validateForm);
    workshopNameArabicController.addListener(validateForm);
    nationalNumberController.addListener(validateForm);
    registrationNumberController.addListener(validateForm);
    licenseNumberController.addListener(validateForm);
    addressController.addListener(validateForm);
    taxNumberController.addListener(validateForm);
    ibanController.addListener(validateForm);

    // Fetch workshop data when screen initializes
    getWorkshopData();

  }
  String taxFromApi="";
  // Fetch workshop data and populate fields
  Future<void> getWorkshopData() async {
    isLoading.value = true;

    try {
      final response = await _repo.getWorkshopData();

      if (response.statusCode == 200 && response.body['data'] != null) {
        final data = response.body['data'];

        // Populate text fields
        workshopNameController.text = data['workshopNameEnglish'] ?? '';
        workshopNameArabicController.text = data['workshopNameArabic'] ?? '';
        workshopContact.text = data['contact'] ?? '';
        nationalNumberController.text = data['unn'] ?? '';
        registrationNumberController.text = data['crn'] ?? '';
        licenseNumberController.text = data['mln'] ?? '';
        addressController.text = data['address'] ?? '';
        taxNumberController.text = data['taxVatNumber'] ?? '';
        taxFromApi = data['taxVatNumber'] ?? '';
        // If API returned an empty bank account, keep the 'SA' prefix as default
        final bankAcc = (data['bankAccountNumber'] ?? '').toString();
        if (bankAcc.trim().isEmpty) {
          ibanController.text = 'SA';
        } else {
          ibanController.text = bankAcc;
        }
        // Place cursor at the end so user can continue typing after 'SA'
        ibanController.selection = TextSelection.fromPosition(
          TextPosition(offset: ibanController.text.length),
        );

        // Set mobile workshop checkbox
        isMobileWorkshop.value = data['isAvailableMobileWorkshop'] ?? false;



        // Set location if available
        if (data['workshopGEOlocation'] != null &&
            data['workshopGEOlocation']['coordinates'] != null &&
            data['workshopGEOlocation']['coordinates'].length >= 2) {
          final coords = data['workshopGEOlocation']['coordinates'];
          selectedLocation = LatLng(
            coords[1].toDouble(), // latitude is second
            coords[0].toDouble(), // longitude is first
          );
          isLocationAdded.value = true;
        }

        // Set regular working schedule
        if (data['regularWorkingSchedule'] != null) {
          final regular = data['regularWorkingSchedule'];
          regularDayFrom.value = (regular['startDay'] ?? 'sunday')
              .toLowerCase();
          regularDayTo.value = (regular['endDay'] ?? 'friday').toLowerCase();

          if (regular['startTime'] != null) {
            regularFrom.value = _parseTime(regular['startTime']);
          }
          if (regular['endTime'] != null) {
            regularTo.value = _parseTime(regular['endTime']);
          }
        }

        // Set ramadan working schedule
        if (data['ramadanWorkingSchedule'] != null) {
          final ramadan = data['ramadanWorkingSchedule'];
          ramadanDayFrom.value = (ramadan['startDay'] ?? 'sunday')
              .toLowerCase();
          ramadanDayTo.value = (ramadan['endDay'] ?? 'thursday').toLowerCase();

          if (ramadan['startTime'] != null) {
            ramadanFrom.value = _parseTime(ramadan['startTime']);
          }
          if (ramadan['endTime'] != null) {
            ramadanTo.value = _parseTime(ramadan['endTime']);
          }
        }

        validateForm();
      } else {
        showCustomSnackBar(
          response.statusText ?? 'failed_to_load_workshop_data'.tr,
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar('error_occurred'.tr, isError: true);
      debugPrint('Error loading workshop data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to parse time string (HH:mm) to TimeOfDay
  TimeOfDay _parseTime(String timeString) {
    try {
      final parts = timeString.split(':');
      if (parts.length == 2) {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    } catch (e) {
      debugPrint('Error parsing time: $e');
    }
    return const TimeOfDay(hour: 8, minute: 0);
  }

  @override
  void onClose() {
    workshopNameController.dispose();
    workshopNameArabicController.dispose();
    nationalNumberController.dispose();
    registrationNumberController.dispose();
    licenseNumberController.dispose();
    addressController.dispose();
    taxNumberController.dispose();
    ibanController.dispose();
    super.onClose();
  }
}
