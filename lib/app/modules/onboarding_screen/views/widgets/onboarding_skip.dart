import 'package:alert_brains/app/modules/onboarding_screen/controllers/onboarding_controller.dart';
import 'package:alert_brains/global_presentation/build_back_icon.dart';
import 'package:alert_brains/global_presentation/build_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingSkip extends StatelessWidget {
  final Color color;
  const OnboardingSkip({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildBackIcon(
            color: color,
          ),
          BuildTextButton(
            text: 'Skip',
            onPressed: () {
              Get.find<OnboardingController>().nextPage(skip: true);
            },
            color: color,
          )
        ],
      ),
    );
  }
}
