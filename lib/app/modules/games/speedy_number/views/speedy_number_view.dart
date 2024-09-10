import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/app/modules/count_down/views/count_down_view.dart';
import 'package:alert_brains/app/modules/games/speedy_number/controllers/speedy_number_controller.dart';
import 'package:alert_brains/global_presentation/build_elevated_button.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/global_presentation/default_app_bar.dart';
import 'package:alert_brains/global_presentation/game_details_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpeedyNumberView extends StatelessWidget {
  final GameDetailsModel gameDetailsModel;
  final bool trial;
  const SpeedyNumberView({super.key, required this.gameDetailsModel, required this.trial});

  @override
  Widget build(BuildContext context) {
    SpeedyNumberController controller =
        Get.put(SpeedyNumberController(gameDetailsModel: gameDetailsModel, trial: trial));

    return WillPopScope(
      onWillPop: () async {
        Get.delete<SpeedyNumberController>();
        Get.delete<CountDownController>();
        return true;
      },
      child: GetBuilder<SpeedyNumberController>(
        builder: (_) {
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
                          questionNumber: controller.questionNo,
                          trials: 3,
                          coins: controller.userModel.coins,
                        ),
                        SizedBox(
                          height: .15.sh,
                        ),
                        if (controller.questionNumbers.isNotEmpty &&
                            !controller.hideQuestion)
                          SizedBox(
                            width: .5.sw,
                            height: .5.sw,
                            child: BuildText(
                              text: controller.questionNumbers.last.toString(),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                              color: controller.colors[
                                  controller.questionNumbers.lastIndexOf(
                                      controller.questionNumbers.last)],
                            ),
                          ),
                        if (controller.hideQuestion) ...[
                          SizedBox(
                            width: .9.sw,
                            child: TextField(
                              controller: controller.textEditingController,
                              onTap: () {
                                controller.stopTimerWhenUserOpenKeyBoard();
                              },
                              decoration: InputDecoration(
                                label: BuildText(
                                  text: 'Your Answer',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          SizedBox(
                            width: .5.sw,
                            height: 33.h,
                            child: BuildElevatedButton(
                              onPressed: () {
                                controller.checkUserAnswer();
                              },
                              title: 'Submit',
                              color: Color(0xff676767),
                              textColor: Colors.white,
                              borderRadius: 15,
                            ),
                          )
                        ],
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                )
              : CountDownView(
                  title: 'Speedy Numbers',
                  description: 'Remember the numbers,\nthen enter the answer',
                  color: AppColors.memoColor,
                  onCountdownFinish: controller.startGame,
                  count: 5,
                );
        },
      ),
    );
  }
}
