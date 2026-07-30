import 'package:Senaeya/View/Screens/add_spare_parts_screen/controller/add_spare_parts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Utils/AppColors/app_colors.dart';
import '../custom_text/custom_text.dart';


class CustomDataTable<T> extends StatelessWidget {
  final List<String> headers;
  final List<int> flexValues;
  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;
  final Function(int index)? onItemTap;
  final int? selectedIndex;
  final Color headerColor;
  final Color headerTextColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color dividerColor;
  final double headerHeight;
  final double itemHeight;
  final double borderRadius;
  final bool showRadioButton;
  final int radioButtonColumnIndex;

  const CustomDataTable({
    super.key,
    required this.headers,
    required this.flexValues,
    required this.items,
    required this.itemBuilder,
    this.onItemTap,
    this.selectedIndex,
    this.headerColor = AppColors.primary,
    this.headerTextColor = Colors.white,
    this.selectedItemColor = const Color(0xFFE3F2FD),
    this.unselectedItemColor = const Color(0xffF4F5F7),
    this.dividerColor = Colors.white,
    this.headerHeight = 40,
    this.itemHeight = 50,
    this.borderRadius = 8,
    this.showRadioButton = true,
    this.radioButtonColumnIndex = -1, // -1 means last column
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table Header
        Container(
          height: headerHeight,
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            border: Border(
              bottom: BorderSide(
                color: dividerColor,
                width: 2.w,
              ),
            ),
          ),
          child: Row(
            children: _buildHeaderRow(),
          ),
        ),

        // Table Body
        Expanded(
          child: ListView.builder(
            itemCount: items.length < 6 ? 6 : items.length, // Show minimum 6 rows
            itemBuilder: (context, index) {
              if (index < items.length) {
                // Show actual data item
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () => onItemTap?.call(index),
                  child: Container(
                    height: itemHeight,
                    decoration: BoxDecoration(
                      color: isSelected ? selectedItemColor : unselectedItemColor,
                      border: const Border(
                        bottom: BorderSide(color: Colors.white, width: 1),
                      ),
                      borderRadius: index == (items.length < 6 ? 6 : items.length) - 1
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              bottomRight: Radius.circular(borderRadius)
                            )
                          : BorderRadius.zero,
                    ),
                    child: itemBuilder(items[index], index),
                  ),
                );
              } else {
                // Show blank row
                return Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                    color: unselectedItemColor,
                    border: const Border(
                      bottom: BorderSide(color: Colors.white, width: 1),
                    ),
                    borderRadius: index == 5 ? BorderRadius.only( // Last blank row
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius)
                    ) : BorderRadius.zero,
                  ),
                  child: Row(
                    children: _buildBlankRow(),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildHeaderRow() {
    List<Widget> headerWidgets = [];

    for (int i = 0; i < headers.length; i++) {
      headerWidgets.add(
        Expanded(
          flex: flexValues[i],
          child: Center(
            child: CustomText(
             text:  headers[i],
                overflow: TextOverflow.visible,

                color: headerTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
            ),
          ),
        ),
      );

      // Add divider between columns (except for the last column)
      if (i < headers.length - 1) {
        headerWidgets.add(
          Container(
            width: 1,
            height: headerHeight*0.8,
            color: dividerColor,
          ),
        );
      }
    }

    return headerWidgets;
  }

  List<Widget> _buildBlankRow() {
    List<Widget> blankRowWidgets = [];

    for (int i = 0; i < headers.length; i++) {
      blankRowWidgets.add(
        Expanded(
          flex: flexValues[i],
          child: Container(
            height: itemHeight,
            child: const SizedBox(), // Empty space
          ),
        ),
      );
    }

    return blankRowWidgets;
  }
}

// Specific implementation for Works table
class WorksDataTable extends StatelessWidget {
  final List<dynamic> works;
  final Function(int index) onWorkTap;
  final int selectedIndex;

  const WorksDataTable({
    super.key,
    required this.works,
    required this.onWorkTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDataTable<dynamic>(
      headers: ['code'.tr, 'works'.tr, 'Qty'.tr, 'price'.tr, 'total'.tr],
      flexValues: const [1, 4, 1, 1, 1],
      items: works,
      selectedIndex: selectedIndex,
      onItemTap: onWorkTap,
      itemBuilder: (work, index) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: CustomText(
                  text: work.code,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CustomText(
                  text: work.name,
                  fontSize: 12,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CustomText(
                  text: work.qty.toString(),
                  overflow: TextOverflow.visible,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CustomText(
                  text: work.price.toStringAsFixed(2),
                  fontSize: 12,
                  overflow: TextOverflow.visible,

                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Center(
                    child: CustomText(
                      text: work.total.toStringAsFixed(2),
                      fontSize: 12,
                      overflow: TextOverflow.visible,

                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: -7,
                    child: Transform.scale(
                      scale: 0.5,
                      child: Radio<int>(
                        value: index,
                        groupValue: selectedIndex,
                        onChanged: (value) {
                          if (value != null) {
                            onWorkTap(value);
                          }
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        activeColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Specific implementation for Spare Parts table
class SparePartsDataTable extends StatelessWidget {
  final List<WorkItem> spareParts;
  final Function(int index) onSparePartTap;
  final int selectedIndex;

  const SparePartsDataTable({
    super.key,
    required this.spareParts,
    required this.onSparePartTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            height: 40.w,
            decoration:  BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(
              Radius.circular(4.r),

              ),
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 2.w)
              )
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomText(
                     text:  'code'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,

                        fontSize: 16.sp,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                Container(width: 1, height: 26.w, color: Colors.white),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: CustomText(
                      text: 'works'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      overflow: TextOverflow.visible,

                        fontSize: 16.sp,
                    ),
                  ),
                ),
                Container(width: 1, height: 26.w, color: Colors.white),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomText(
                     text:  'Qty'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      overflow: TextOverflow.visible,

                        fontSize: 13.sp,
                    ),
                  ),
                ),
                Container(width: 1, height: 26.w, color: Colors.white),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomText(
                      text: 'price'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      overflow: TextOverflow.visible,

                        fontSize: 16.sp,
                    ),
                  ),
                ),
                Container(width: 1, height: 26.w, color: Colors.white),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomText(
                     text:  'total'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      overflow: TextOverflow.visible,

                        fontSize: 12.sp,
                      ),
                    ),
                ),
              ],
            ),
          ),
          // Table Body
          Expanded(
            child: ListView.builder(
              itemCount: spareParts.length < 6 ? 6 : spareParts.length, // Show minimum 6 rows
              itemBuilder: (context, index) {
                if (index < spareParts.length) {
                  // Show actual spare part item
                  final sparePart = spareParts[index];
                  final isSelected = sparePart.selected;

                  return GestureDetector(
                    onTap: () => onSparePartTap(index),
                    child: Container(
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : const Color(0xffF4F5F7),
                        border: const Border(
                          bottom: BorderSide(color: Colors.white, width: 2),
                        ),
                        borderRadius: index == (spareParts.length < 6 ? 6 : spareParts.length) - 1
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r)
                              )
                            : BorderRadius.zero,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CustomText(
                                text: sparePart.code,
                                fontSize: 12.sp,
                                overflow: TextOverflow.visible,

                              ),
                            ),
                          ),

                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: sparePart.isNew ? Colors.green : AppColors.red,
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 4.w,),
                                  Flexible(
                                    child: CustomText(
                                      text: sparePart.name,
                                      fontSize: 12.sp,

                                      overflow: TextOverflow.visible,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CustomText(
                                text: sparePart.qty.toString(),
                                fontSize: 12.sp,
                                overflow: TextOverflow.visible,

                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CustomText(
                                text: sparePart.price.toString(),
                                fontSize: 12.sp,
                                overflow: TextOverflow.visible,

                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                Center(
                                  child: CustomText(
                                    text: sparePart.total.toStringAsFixed(2),
                                    fontSize: 12,
                                    overflow: TextOverflow.visible,

                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  right: -7,
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: Radio<int>(
                                      value: index,
                                      groupValue: selectedIndex,
                                      onChanged: (value) {
                                        if (value != null) {
                                          onSparePartTap(value);
                                        }
                                      },
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      activeColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Show blank row
                  return Container(
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffF4F5F7),
                      border: const Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                      ),
                      borderRadius: index == 5 ? BorderRadius.only( // Last blank row
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r)
                      ) : BorderRadius.zero,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 40.w,
                            child: const SizedBox(), // Empty space
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 40.w,
                            child: const SizedBox(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 40.w,
                            child: const SizedBox(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 40.w,
                            child: const SizedBox(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 40.w,
                            child: const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
