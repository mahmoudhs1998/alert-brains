import 'package:alert_brains/app/modules/games/helper/levels_screen/levels_screen.dart';
import 'package:alert_brains/app/modules/games/power_memo/views/power_memo_view.dart';
import 'package:alert_brains/app/modules/games/quick_math/quick_math_game/view/quick_math_view.dart';
import 'package:alert_brains/app/modules/games/speedy_number/views/speedy_number_view.dart';
import 'package:alert_brains/app/modules/games/xo/screens/xo_view.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:alert_brains/services/ads_manager/ads_manager_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alert_brains/app/modules/games/helper/count_down_screen/count_down_screen.dart';
import 'package:alert_brains/app/modules/main_menu_screen/controllers/main_menu_controller.dart';
import 'package:alert_brains/app/modules/profile_screen/profile_screen.dart';
import 'package:alert_brains/app/modules/settings_screen/view.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/app/modules/main_menu_screen/views/widgets/card_game.dart';
import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/global_presentation/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    MainMenuController controller = Get.put(MainMenuController());
    AdManager AdManagercontroller = Get.put(AdManager());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryPurple,
        centerTitle: true,
        title: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
          child: Obx(() => AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Challenging Mind Games',
                  ),
                  WavyAnimatedText(controller.dataLoaded.value
                      ? controller.userModel.name
                      : ''),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              )),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Obx(() => controller.dataLoaded.value
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<AdManager>(
                        builder: (controller) => controller.isLoaded
                            ? SizedBox(
                                width:
                                    controller.bannerAd!.size.width.toDouble(),
                                height:
                                    controller.bannerAd!.size.height.toDouble(),
                                child: AdWidget(ad: controller.bannerAd!),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          BuildText(
                            text: "Welcome In",
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          BuildText(
                              text: "Alert Brains",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.green),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/coin.svg"),
                              SizedBox(
                                width: 8.w,
                              ),
                              // ReusableFractionallySizedBox(widthFactor: 0.8, imagePath: 'assets/images/coin.svg',),
                              BuildText(
                                text: controller.userModel.coins.toString(),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF797979),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 37.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.whiteGreen),
                            child: IconButton(
                              onPressed: () {
                                Get.to(SettingsView());

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const SettingsView(),
                                //   ),
                                // );
                              },
                              icon: Icon(
                                Icons.settings,
                                color: AppColors.white,
                                size: 22.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 37.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.whiteGreen),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.person,
                                color: AppColors.white,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CardGame(
                    text: 'Quick Math',
                    imagePath: "assets/images/addtion.png",
                    cardColor: const Color(0xFFCAE5BD),
                    percentageColor: const Color(0xFFCAE5BD),
                    onTap: () {
                      Get.to(
                        () => !controller.trialModel.quickMath &&
                                controller.userModel.gamesLevelModel.quickMath
                                        .level ==
                                    0
                            ? MathGameScreen(
                                gameDetailsModel: controller
                                    .userModel.gamesLevelModel.quickMath,
                                trial: !controller.trialModel.quickMath,
                              )
                            : LevelScreenOfGames(
                                containerColor: Color(0xFFCAE5BD),
                                appBarButtonColor: Color(0xFFCAE5BD),
                                appBarTitle: 'Quick Math',
                                gameType: GamesType.quickMath,
                              ),
                      );
                      /* Get.to(
                        () => CountdownScreen(
                          duration: 5,
                          resonOfWaiting: 'Choose The Right Answer',
                          onCountdownFinish: () {
                            Get.off(() => QuickMathGameTrialView());
                          },
                        ),
                      );*/
                    },
                    gameType: GamesType.quickMath,
                    description:
                        'Solve addition and subtraction puzzles swiftly!',
                  ),
                  CardGame(
                    text: 'Speedy Numbers',
                    imagePath: "assets/images/Group 5618.png",
                    cardColor: AppColors.speedyColor,
                    percentageColor: AppColors.speedyColor,
                    onTap: () {
                      // AdManagercontroller.loadInterstitialAd();
                      Get.to(
                        () => !controller.trialModel.speedyNumbers &&
                                controller.userModel.gamesLevelModel
                                        .speedyNumbers.level ==
                                    0
                            ? SpeedyNumberView(
                                gameDetailsModel: controller
                                    .userModel.gamesLevelModel.speedyNumbers,
                                trial: !controller.trialModel.speedyNumbers,
                              )
                            : LevelScreenOfGames(
                                containerColor: AppColors.speedyColor,
                                appBarButtonColor: AppColors.speedyColor,
                                appBarTitle: 'Speedy Numbers',
                                gameType: GamesType.speedyNumbers,
                              ),
                      );
                    },
                    gameType: GamesType.speedyNumbers,
                    description:
                        'Quick math with disappearing numbers. How many can you solve in time?',
                  ),
                  CardGame(
                    text: 'Mind Forge',
                    imagePath: "assets/images/Collab-bro (1) 1.png",
                    cardColor: const Color(0xFFCAE5BD),
                    percentageColor: const Color(0xFFCAE5BD),
                    onTap: () {},
                    gameType: GamesType.focus,
                    description:
                        'Conquer untamed puzzles with focused mastery.',
                  ),
                  CardGame(
                    text: 'Power Memo',
                    imagePath: "assets/images/powerMemo.png",
                    cardColor: AppColors.Yellow,
                    percentageColor: AppColors.Yellow,
                    onTap: () {
                      Get.to(
                        () => !controller.trialModel.powerMemo &&
                                controller.userModel.gamesLevelModel.memoPower
                                        .level ==
                                    0
                            ? PowerMemoView(
                                gameDetailsModel: controller
                                    .userModel.gamesLevelModel.memoPower,
                                trial: !controller.trialModel.powerMemo,
                              )
                            : LevelScreenOfGames(
                                containerColor: Color(0xffF8E3B5),
                                appBarButtonColor: Color(0xffF8E3B5),
                                appBarTitle: 'Power Memo',
                                gameType: GamesType.memo,
                              ),
                      );
                    },
                    gameType: GamesType.memo,
                    description:
                        'Challenge your memory in Power Memo! Recall the sequence of colored blocks to advance to higher levels.',
                  ),
                  CardGame(
                    text: 'XoXo',
                    imagePath: "assets/images/xo.png",
                    cardColor: AppColors.Purple,
                    percentageColor: AppColors.Purple,
                    onTap: () {
                      Get.to(() => CountdownScreen(
                            duration: 5,
                            resonOfWaiting: 'XO Play ',
                            onCountdownFinish: () {
                              Get.off(() => XoView());
                            },
                          ));
                    },
                    description:
                        'Experience X O game with AI or challenge a friend for ultimate strategy showdowns!',
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 85.0.w, bottom: 10.h, top: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: AppColors.neGameGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.0.w),
                            child: BuildText(
                              text: "New Game Are Coming Soon",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          BuildText(
                              text: "!",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.green),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : LoadingIndicator(isLoading: true)),
    );
  }
}
