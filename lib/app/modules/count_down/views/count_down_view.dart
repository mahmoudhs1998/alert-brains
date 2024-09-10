import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/global_presentation/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountDownView extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final int count;
  final Function onCountdownFinish;

  const CountDownView(
      {super.key,
      required this.title,
      required this.description,
      required this.color,
      required this.count,
      required this.onCountdownFinish});

  @override
  Widget build(BuildContext context) {
    CountDownController controller =
        Get.put(CountDownController(count, onCountdownFinish));
    print(count);
    print(controller.counter);
    return Scaffold(
      backgroundColor: color,
      appBar: DefaultAppBar(
        title: title,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            BuildText(
              text: description,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: .15.sh,
            ),
            SizedBox(
              height: .4.sw,
              width: .4.sw,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteGrey,
                child: GetBuilder<CountDownController>(
                    builder: (_) => BuildText(
                          text: controller.counter.toString(),
                          color: AppColors.white,
                          fontSize: 25.sp,
                        )),
              ),
            ),
            SizedBox(
              height: .06.sh,
            ),
            GetBuilder<CountDownController>(
              builder: (_) => controller.counter <= 1
                  ? BuildText(
                      text: 'Ready to Start',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
