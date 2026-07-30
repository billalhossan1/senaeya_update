import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double? width; // Add optional width parameter
  final double? textSize; // Add optional width parameter
  final bool expanded; // Add parameter to control if button should be expanded

  const NextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textSize,
    this.backgroundColor = const Color(0xFF1976D2), // default blue
    this.textColor = Colors.white, // default white
    this.width, // Optional width
    this.expanded = true, // Default to expanded behavior
  });

  @override
  Widget build(BuildContext context) {
    Widget button = GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, // Use custom width if provided
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: CustomText(
              text: text,
              fontSize: textSize??18.w,
              fontWeight: FontWeight.bold,
              color: textColor,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );

    // Return expanded or fixed width based on parameters
    return expanded && width == null
        ? Expanded(child: button)
        : button;
  }
}
