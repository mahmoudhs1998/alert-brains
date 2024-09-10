import 'dart:math';

import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/app/modules/count_down/views/count_down_view.dart';
import 'package:alert_brains/app/modules/games/power_memo/controllers/power_memo_controller.dart';
import 'package:alert_brains/global_presentation/default_app_bar.dart';
import 'package:alert_brains/global_presentation/game_details_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PowerMemoView extends StatelessWidget {
  final GameDetailsModel gameDetailsModel;
  final bool trial;
  const PowerMemoView({super.key, required this.gameDetailsModel, required this.trial});

  @override
  Widget build(BuildContext context) {
    PowerMemoController controller =
        Get.put(PowerMemoController(gameDetailsModel: gameDetailsModel, trial: trial));
    print(controller.questionNumbers);
    return WillPopScope(
      onWillPop: () async {
        Get.delete<PowerMemoController>();
        Get.delete<CountDownController>();
        return true;
      },
      child: GetBuilder<PowerMemoController>(
        builder: (_) {
          Color boxColor = controller
              .boxColors[controller.boxesColoredCount[controller.questionNo]]!;
          return controller.start
              ? Scaffold(
                  backgroundColor: AppColors.memoColor,
                  appBar: DefaultAppBar(
                    title: trial ? 'Trial' : "Level " + (gameDetailsModel.level + 1).toString(),
                  ),
                  body: SizedBox(
                    height: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: .03.sh,
                        ),
                        GameDetailsRow(
                          counter: controller.timeOutCounter,
                          questionNumber: controller.questionNo + 1,
                          trials: 3,
                          coins: controller.userModel.coins,
                        ),
                        SizedBox(
                          height: .15.sh,
                        ),
                        SizedBox(
                          width: .5.sw,
                          height: .5.sw,
                          child: GridView.count(
                            crossAxisCount: sqrt(controller
                                    .boxesFrameSize[controller.questionNo])
                                .toInt(),
                            children: List.generate(
                              controller.boxesFrameSize[controller.questionNo],
                              (index) => Padding(
                                padding: EdgeInsets.all(.1.h),
                                child: InkWell(
                                  onTap: !controller.boxClickable
                                      ? null
                                      : () {
                                          controller.checkUserSelection(index);
                                        },
                                  child: Container(
                                    width: 50.h,
                                    height: 50.h,
                                    color: controller.questionNumbers
                                            .contains(index)
                                        ? controller.isRightAnswer(index)
                                            ? boxColor
                                            : Colors.redAccent
                                        : AppColors.whiteGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                )
              : CountDownView(
                  title: 'Power Memo',
                  description:
                      'Remember the colored blocks,\nthen select those items back',
                  color: AppColors.memoColor,
                  onCountdownFinish: controller.startGame,
                  count: 5,
                );
        },
      ),
    );
  }
}
