import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/Utils/AppImg/app_img.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String? hint;
  final ValueChanged<T?>? onChanged;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? fillColor;
  final Widget? icon;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.height,
    this.width,
    this.borderRadius = 24.0,
    this.fillColor,
    this.icon,
    this.iconSize,
    this.padding,
    this.hintStyle,
    this.itemStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: fillColor ?? AppColors.textFiledColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          dropdownColor: AppColors.textFiledColor,
          value: value,
          hint: hint != null ? Center(child: CustomText(text: hint!)) : null,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Center(
                child: CustomText(
                  text: item.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
          icon: SvgPicture.asset(
            AppIcon.dropDown,
            height: 10.w,
            width: 10.w,
          ),
          iconSize: iconSize ?? 24,
          itemHeight: 60.h, // Increase item height to accommodate 2 lines of text
          menuMaxHeight: 600.h, // Set maximum height for dropdown menu
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
          // Add selectedItemBuilder to handle selected item display
          selectedItemBuilder: (BuildContext context) {
            return items.map((T item) {
              return Center(
                child: CustomText(
                  text: item.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

