import 'package:alert_brains/app/modules/onboarding_screen/controllers/onboarding_controller.dart';
import 'package:alert_brains/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (OnboardingController controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.onBoardingList.length,
          (index) => AnimatedContainer(
            margin: EdgeInsets.only(right: 7.w),
            duration: const Duration(milliseconds: 900),
            width: controller.currentPage == index ? 30.w : 13.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: _getIndicatorColor(index),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

Color _getIndicatorColor(int index) {
  switch (index) {
    case 0:
      return AppColors.primaryPurple;
    case 1:
      return AppColors.secondaryYellow;
    case 2:
      return AppColors.green;
    default:
      return Colors.grey;
  }
}
