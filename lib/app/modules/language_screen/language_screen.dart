import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Constants/app_colors.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.whiteGreen,
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30.sp,
              color: AppColors.green,
            ),
          ),
        ),
        title: Text(
          "Language",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteGrey,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("English",
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
                  Radio(
                      value: "English",
                      groupValue: "English",
                      onChanged: (value) {},
                      activeColor: AppColors.green,
                      hoverColor: AppColors.green),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Arabic",
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
                  Radio(
                      value: "Arabic",
                      groupValue: "English",
                      onChanged: (value) {},
                      hoverColor: AppColors.green),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("French",
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
                  Radio(
                      value: "French",
                      groupValue: "English",
                      onChanged: (value) {},
                      hoverColor: AppColors.green),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("German",
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
                  Radio(
                    value: "German",
                    groupValue: "English",
                    onChanged: (value) {},
                    hoverColor: AppColors.green,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
              margin: EdgeInsets.only(bottom: 40.h),
              height: 40.h,
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 100.h, vertical: 0.w),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)), // Set circular radius

                onPressed: () {  },
                child: Text( "Start" ,
                  style: TextStyle(
                      fontFamily: 'DM Mono', fontSize: 20.sp, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
