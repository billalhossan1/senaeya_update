import 'package:intl/intl.dart';

class FormateDateTime {
  /// Format example: "AM 10:42 2025-07-16"
  static String formatDateTime(dynamic dateTime) {
    try {
      DateTime dt;

      if (dateTime is String) {
        dt = DateTime.parse(dateTime);
      } else if (dateTime is DateTime) {
        dt = dateTime;
      } else {
        return '';
      }

      DateTime localDateTime = dt.toLocal();

      String formattedTime = DateFormat('a hh:mm').format(localDateTime);
      String formattedDate = DateFormat('yyyy-MM-dd').format(localDateTime);

      return '$formattedTime $formattedDate';
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  /// New Method: Converts to readable format like "July 16, 2025 at 10:42 AM"
  static String convertToDueDateFormat(dynamic dateTime) {
    try {
      DateTime dt;

      if (dateTime is String) {
        dt = DateTime.parse(dateTime);
      } else if (dateTime is DateTime) {
        dt = dateTime;
      } else {
        return '';
      }

      DateTime localDateTime = dt.toLocal();

      String formattedDate = DateFormat('yyyy-MM-dd').format(localDateTime);
      // String formattedTime = DateFormat('hh:mm a').format(localDateTime);

      return formattedDate;
    } catch (e) {
      print('Error converting date: $e');
      return '';
    }
  }

///13-10-2024 8:24 PM
  static String formatDateTimeForSubscription(String isoString) {
    try {
      // Parse the ISO date
      DateTime dateTime = DateTime.parse(isoString).toLocal();

      // Format it as "dd-MM-yyyy h:mm a"
      String formatted = DateFormat('dd-MM-yyyy h:mm a').format(dateTime);

      return formatted;
    } catch (e) {
      return isoString; // fallback if parsing fails
    }
  }
}
