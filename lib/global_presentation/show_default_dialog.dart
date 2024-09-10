import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

Future<void> showDefaultDialog(
    {required String imagePath,
    required String dialogText,
    required Color buttonColor,
    required Color buttonBorderColor,
    required String mainButtonText,
    required String btnTitle,
      void Function()? onMainButtonPressed,
  void Function()? onBackButtonPressed,

    }) async {
  Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: AppColors.white,
    content: Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.8, // Adjust as per your requirement
          child: Image.asset(
            imagePath,
            fit: BoxFit
                .contain, // Adjust the BoxFit property as per your requirement
          ),
        ),
        SizedBox(height: 10.h),
        BuildText(
          text: dialogText,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: onMainButtonPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                ),
              ),
              child: BuildText(
                text: mainButtonText,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white),
              ),
            ),
            OutlinedButton(
              onPressed: onBackButtonPressed,
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(color: buttonBorderColor, width: 2.w)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                ),
              ),
              child: BuildText(
                text: 'Back',
                style: TextStyle(
                  color: buttonBorderColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      // ElevatedButton(
      //   onPressed: onPressed ??
      //       () {
      //         Get.back();
      //       },
      //   child: BuildText(text: btnTitle),
      // ),
    ],
  );
}
