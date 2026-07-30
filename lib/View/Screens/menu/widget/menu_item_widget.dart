import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  const MenuItem({super.key, required this.icon, required this.label, required this.onTap,  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
           SvgPicture.asset(
              icon,
              height: 30.w,
              width: 30.w,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: CustomText(
                text: label,
                textAlign: TextAlign.start,
                // Pass raw font size; CustomText will apply .sp internally
                fontSize: 15.sp,
                minFontSize: 10,
                maxLines: 2,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
           ],
         ),
       ),
     );
   }
 }
