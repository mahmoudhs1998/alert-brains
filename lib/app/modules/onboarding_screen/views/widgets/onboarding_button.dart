import 'package:alert_brains/app/modules/onboarding_screen/controllers/onboarding_controller.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
          margin: EdgeInsets.only(bottom: 30.h),
          height: 35.h,
          child: GetBuilder(
            builder: (OnboardingController controller) {
              return SizedBox(
                width: .75.sw,
                child: MaterialButton(
                  onPressed: () => controller.nextPage(),
                  color: controller.getCurrentColor(),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  // Set circular radius
                  child: BuildText(
                    text: controller.currentPage >= 2 ? "Start" : "Next",
                    style: TextStyle(
                        fontFamily: 'DM Mono',
                        fontSize: 18.sp,
                        color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
