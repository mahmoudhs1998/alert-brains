import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/app/modules/count_down/views/count_down_view.dart';
import 'package:alert_brains/app/modules/games/quick_math/quick_math_game/controller/quick_math_controller.dart';
import 'package:alert_brains/constants/app_colors.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/global_presentation/default_app_bar.dart';
import 'package:alert_brains/global_presentation/game_details_row.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MathGameScreen extends StatelessWidget {
  final GameDetailsModel gameDetailsModel;
  final bool trial;

  const MathGameScreen(
      {Key? key, required this.gameDetailsModel, required this.trial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MathGameController controller =
        Get.put(MathGameController(trial, gameDetailsModel));

    return WillPopScope(
      onWillPop: () async {
        Get.delete<MathGameController>();
        Get.delete<CountDownController>();
        return true;
      },
      child: GetBuilder<MathGameController>(
        builder: (_) {
          return controller.start
              ? Scaffold(
                  backgroundColor: AppColors.whiteGreen,
                  appBar: DefaultAppBar(
                    title:
                        trial ? 'Trial' : 'Level ${gameDetailsModel.level + 1}',
                  ),
                  body: Obx(
                    () => Column(
                      children: [
                        SizedBox(
                          height: .03.sh,
                        ),
                        GameDetailsRow(
                          counter: controller.secondsRemaining.value,
                          questionNumber: controller.questionNumber.value,
                          trials: UserRepository.userModel.gamesLevelModel.quickMath.trials,
                          coins: UserRepository.userModel.coins,
                        ),
                        SizedBox(
                          height: .15.sh,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            BuildText(
                              text: controller.getQuestionBody(),
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w900,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 70.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: controller.options
                                  .map((option) => GestureDetector(
                                        onTap: () =>
                                            controller.checkAnswer(option),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteGrey,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          width: 80.w,
                                          height: 50.h,
                                          alignment: Alignment.center,
                                          child: BuildText(
                                            text: option.toString(),
                                            fontSize: 20.0.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              : CountDownView(
                  title: 'Quick Math',
                  description: 'Choose The Right Answer',
                  color: AppColors.whiteGreen,
                  onCountdownFinish: controller.startGame,
                  count: 5,
                );
        },
      ),
    );
  }
}
