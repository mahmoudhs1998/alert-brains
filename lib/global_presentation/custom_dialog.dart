import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Constants/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final String imagePath;
  final String dialogText;
  final String mainButtonText;
  final Color buttonColor;
  final Color buttonBorderColor;

  const CustomDialog({super.key,
    required this.imagePath,
    required this.dialogText,
    required this.buttonColor,
    required this.buttonBorderColor,
    required this.mainButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FractionallySizedBox(
            widthFactor: 0.8, // Adjust as per your requirement
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // Adjust the BoxFit property as per your requirement
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Do something when the user presses the "OK" button
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
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
              onPressed: () {},
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(color: buttonBorderColor, width: 2.w)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
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
      ],
    );
  }
}
