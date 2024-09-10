import 'package:alert_brains/app/modules/auth/views/auth_view.dart';
import 'package:alert_brains/app/modules/onboarding_screen/data/models/onboarding_txt_model.dart';
import 'package:alert_brains/constants/app_colors.dart';
import 'package:alert_brains/constants/hive_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingController extends GetxController {
  final List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        title: ["Welcome to Our app,\nWhere Fun "],
        subtitle: "Meets Learning!",
        image: "assets/images/onboarding1.png",
        subColor: const Color(0xff795BC0)),
    OnBoardingModel(
        title: ["Get ready for Adventure", " Mental \nGames and Challenges"],
        subtitle: "\nFull of Educational,",
        image: "assets/images/onboarding2.png",
        subColor: const Color(0xffFFB61D)),
    OnBoardingModel(
        title: [
          "Each Game has a Specific \nGoal and a Fun,",
          " Way \nto play!"
        ],
        subtitle: " Exciting",
        image: "assets/images/onboading3.png",
        subColor: const Color(0xff7BC05B))
  ];

  late PageController pageController;
  int currentPage = 0;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void nextPage({bool? skip}) async {
    currentPage++;
    if (currentPage > onBoardingList.length - 1 || skip != null) {
      var box = Hive.box(HiveKeys.settingBox);
      box.put(HiveKeys.onboardingFieldKey, true);
      print(box.get(HiveKeys.onboardingFieldKey));
      await box.close();
      Get.off(() => const SignInSignUpScreen());
    } else {
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  Color getCurrentColor() {
    if (currentPage == 0) {
      return AppColors.primaryPurple;
    } else if (currentPage == 1) {
      return AppColors.secondaryYellow;
    } else {
      return AppColors.green;
    }
  }
}
