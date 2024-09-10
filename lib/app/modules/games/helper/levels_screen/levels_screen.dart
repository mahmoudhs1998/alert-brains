import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/games/power_memo/views/power_memo_view.dart';
import 'package:alert_brains/app/modules/games/quick_math/quick_math_game/view/quick_math_view.dart';
import 'package:alert_brains/app/modules/games/speedy_number/views/speedy_number_view.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/global_presentation/default_app_bar.dart';
import 'package:alert_brains/global_presentation/no_trials_dialog.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../global_presentation/build_image_sized_box.dart';

class LevelScreenOfGames extends StatelessWidget {
  final GamesType gameType;
  final Color containerColor;
  final Color appBarButtonColor;
  final String appBarTitle;

  const LevelScreenOfGames(
      {super.key,
      required this.containerColor,
      required this.appBarButtonColor,
      required this.appBarTitle,
      required this.gameType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: appBarTitle,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: 30,
          itemBuilder: (context, index) {
            int level = UserRepository.getGameDetailsModel(gameType).level;
            return GestureDetector(
              onTap: level >= index
                  ? () {
                      GameDetailsModel gameDetailsModel =
                          UserRepository.getGameDetailsModel(gameType);
                      int trials = gameDetailsModel.trials;
                      print('trials');
                      print(trials);
                      if (trials > 0) {
                        if (gameType == GamesType.memo) {
                          Get.to(() => PowerMemoView(
                              gameDetailsModel: gameDetailsModel,
                              trial: false));
                        } else if (gameType == GamesType.quickMath) {
                          Get.to(() => MathGameScreen(
                              gameDetailsModel: gameDetailsModel,
                              trial: false));
                        } else if (gameType == GamesType.speedyNumbers) {
                          Get.to(() => SpeedyNumberView(
                              gameDetailsModel: gameDetailsModel,
                              trial: false));
                        }
                      } else {
                        showNoTrialsDialog(gameType);
                      }
                    }
                  : null,
              child: Container(
                margin: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(20.0.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ReusableFractionallySizedBox(
                          widthFactor: level >= index ? 0.75 : 0.45,
                          imagePath: level >= index
                              ? 'assets/images/background_levels.png'
                              : 'assets/images/lock.png',
                        ),
                        Positioned.fill(
                          child: Center(
                            child: BuildText(
                              text: level >= index ? "${index + 1}" : '',
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteGrey,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
