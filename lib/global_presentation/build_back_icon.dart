import 'package:alert_brains/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildBackIcon extends StatelessWidget {
  final Color? color;
  final void Function()? onPressed;

  const BuildBackIcon({super.key, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(6.w, 3.h, 1.w, 3.h),
        decoration: BoxDecoration(
          color: color != null ? color!.withOpacity(.2) : AppColors.whiteGrey,
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: color == null ? 18.sp : 15.sp,
          color: color ?? AppColors.white,
        ),
      ),
    );
  }
}
