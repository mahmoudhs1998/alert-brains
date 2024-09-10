import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/onboarding_screen/controllers/onboarding_controller.dart';
import 'package:alert_brains/app/modules/onboarding_screen/data/models/onboarding_txt_model.dart';
import 'package:alert_brains/app/modules/onboarding_screen/views/widgets/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  final int index;
  const OnboardingPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    OnboardingController controller = Get.find<OnboardingController>();
    OnBoardingModel onBoardingModel = controller.onBoardingList[index];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder(
              builder: (OnboardingController controller) =>
                  OnboardingSkip(color: controller.getCurrentColor())),
          SizedBox(
            height: 300.h,
            width: 300.w,
            child: Image.asset(
              onBoardingModel.image!.toString(),
              height: 250.h,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: onBoardingModel.title[0],
                style: TextStyle(
                  fontSize: 17.sp,
                  color: AppColors.textColor,
                  fontFamily: 'DM Mono',
                ),
                children: [
                  TextSpan(
                    text: onBoardingModel.subtitle,
                    style: TextStyle(
                      color: onBoardingModel.subColor,
                    ),
                  ),
                  if (onBoardingModel.title.length > 1)
                    TextSpan(
                      text: onBoardingModel.title[1],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
