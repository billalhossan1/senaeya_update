import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportCard extends StatelessWidget {
  final String tittle;
  final bool isSelected;
  final VoidCallback? onTap;

  const ReportCard({
    super.key,
    required this.tittle,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Return a flexible card; the parent Row should decide layout (use Expanded there if needed)
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72.h, // fixed height to keep cards uniform
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1771B7) : Colors.grey[100],
          borderRadius: BorderRadius.circular(18.r),
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: tittle,
          textAlign: TextAlign.center,
          color: isSelected ? Colors.white : const Color(0xff959595),
          fontSize: 15, // raw; CustomText applies .sp
          minFontSize: 12,
          maxLines: 2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}