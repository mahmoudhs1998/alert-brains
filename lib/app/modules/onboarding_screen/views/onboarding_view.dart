import 'package:alert_brains/app/modules/onboarding_screen/controllers/onboarding_controller.dart';
import 'package:alert_brains/app/modules/onboarding_screen/views/widgets/onboarding_button.dart';
import 'package:alert_brains/app/modules/onboarding_screen/views/widgets/onboarding_indicator.dart';
import 'package:alert_brains/app/modules/onboarding_screen/views/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.onBoardingList.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    index: index,
                  );
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    const OnboardingIndicator(),
                    SizedBox(
                      height: 15.h,
                    ),
                    const OnboardingButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
