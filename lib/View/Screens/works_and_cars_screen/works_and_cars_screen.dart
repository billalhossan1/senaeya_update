import 'package:Senaeya/Core/AppRoute/app_route.dart';
import 'package:Senaeya/Utils/AppColors/app_colors.dart';
import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:Senaeya/View/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class WorksAndCarsScreen extends StatelessWidget {
  const WorksAndCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return  Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(title: 'works_and_cars_title'.tr, titleColor: Colors.black,centerTitle: true,//blueCloud: true,
           blackHomeIcon: true,),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Center(
                child: Container(
                  width: 0.92.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    children: [
                      SizedBox(height: 50.w,),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoute.workShopWorkScreen);
                        },
                        child: Container(
                          height: 84.w,
                          width: 295.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Center(child: CustomText(text: 'workshop_work_button'.tr,color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22.w,)),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoute.carsCardScreen);
                        },
                        child: Container(
                          height: 84.w,
                          width: 295.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Center(child: CustomText(text: 'types_of_cars_button'.tr,color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22.w,)),
                        ),
                      ),
                      SizedBox(height: 50.w,),
      
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
