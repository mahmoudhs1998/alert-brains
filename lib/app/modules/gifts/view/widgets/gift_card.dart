import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiftCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String imagePath;

  const GiftCard({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: SizedBox(
        width: 150.w,
        height: 180.h,
        child: Card(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SvgPicture.asset(
                    imagePath,
                    semanticsLabel: 'My SVG Image',
                    width: 50.w,
                    height: 53.h,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
