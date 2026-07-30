import 'package:Senaeya/Service/api_url.dart';
import 'package:Senaeya/View/Screens/previous_invoices_screen/common_parse_date/arabic_and_english.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text/custom_text.dart';

class SaudiLicensePlate extends StatelessWidget {
  final String arabicText;
  final String englishText;
  final String numbers;
  final String letters;
  final String? saudiCarPlateImage;
  final dynamic width;
  final String plateNumber;
  final String plateLetters;
  final Color? backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double? height;

  const SaudiLicensePlate({
    super.key,
    this.saudiCarPlateImage,
    this.arabicText = '',
    this.englishText = '',
    this.numbers = '',
    this.letters = '', this.width, required this.plateNumber, required this.plateLetters, this.backgroundColor, required this.borderColor, required this.textColor, this.height,
  });

  // Helper method to convert English numerals to Arabic numerals
  String _convertToArabicNumerals(String englishNumber) {
    const Map<String, String> arabicNumerals = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String result = '';
    for (int i = englishNumber.length-1; i >=0; i--) {
      String char = englishNumber[i];
      result += arabicNumerals[char] ?? char;
    }
    return result;
  }

  // Helper to add a single space between each character in a string
  String _addSpacesBetweenLetters(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return '';
    // Remove any existing spaces then join with single space
    final compact = trimmed.replaceAll(RegExp(r"\s+"), '');
    return compact.split('').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    print("saudiCarPlateImage $saudiCarPlateImage");
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: 120.w,
        height: 68.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Row(
          children: [
            // Main plate area
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(color: backgroundColor),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: borderColor, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Arabic text section - display Arabic numerals converted from plateNumber
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: borderColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: CustomText(
                                  text: (plateNumber.isNotEmpty
                                      ? _convertToArabicNumerals(plateNumber)
                                      : (arabicText.isNotEmpty ? arabicText : _convertToArabicNumerals(numbers))).split('').reversed.join(''),
                                  fontSize: 13.w,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                            // English text section
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: CustomText(
                                  text: Letter.convertTextToArabic(
                                    plateLetters,
                                  ).split(' ').reversed.join(' '),
                                  fontSize: 13.w,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom row - Numbers and Letters
                    Expanded(
                      child: Row(
                        children: [
                          // Numbers section
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: borderColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: CustomText(
                                text: plateNumber.isNotEmpty
                                    ? plateNumber
                                    : numbers,
                                fontSize: 15.w,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                          // Letters section
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: CustomText(
                                text: plateLetters.isNotEmpty
                                    ? _addSpacesBetweenLetters(plateLetters)
                                    : _addSpacesBetweenLetters(letters),
                                fontSize: 13.w,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Green side panel with Saudi emblem
            Container(
              width: 18.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border(left: BorderSide(color: borderColor, width: 1)),
              ),
              child: Image.network(
                ApiConstant.imageBaseUrl + (saudiCarPlateImage ?? ''),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
