import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/main_menu_screen/controllers/main_menu_controller.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class CardGame extends StatelessWidget {
  final String? text;
  final String? imagePath;
  final Color? cardColor;
  final Color? percentageColor;
  final VoidCallback? onTap;
  final GamesType? gameType;
  final String description;

  const CardGame({
    super.key,
    required this.text,
    this.imagePath,
    this.cardColor,
    this.onTap,
    this.percentageColor,
    this.gameType,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    MainMenuController controller = Get.find<MainMenuController>();
    int currentPercent = gameType != null
        ? controller.getCurrentGamePlayedPercent(gameType!)
        : 0;
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cardColor,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildText(
                          text: text!,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF797979),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        BuildText(
                          text: description,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: Image.asset(
                      imagePath!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              if (gameType != null) ...[
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: GFProgressBar(
                    percentage: currentPercent / 100,
                    lineHeight: 15.h,
                    alignment: MainAxisAlignment.spaceBetween,
                    child: Center(
                      child: Text(
                        currentPercent.toString() + ' %',
                        style:
                            TextStyle(fontSize: 15.sp, color: percentageColor),
                      ),
                    ),
                    backgroundColor: AppColors.white,
                    progressBarColor: AppColors.whiteGrey.withOpacity(.8),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
