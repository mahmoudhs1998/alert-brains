import 'package:alert_brains/app/modules/auth/views/auth_view.dart';
import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/main_menu_screen/views/main_menu_view.dart';
import 'package:alert_brains/app/modules/onboarding_screen/views/onboarding_view.dart';
import 'package:alert_brains/constants/hive_keys.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var settingBox = Hive.box(HiveKeys.settingBox);
    bool? onBoardingVisited = settingBox.get(HiveKeys.onboardingFieldKey);

    String? uId = FirebaseAuth.instance.currentUser?.uid;
    return DevicePreview(
      enabled: false,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Math Challenge',
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.white,
                fontFamily: "DM Mono"),
            home: onBoardingVisited == null
                ? const OnBoardingScreen()
                : uId == null
                    ? SignInSignUpScreen()
                    : MainMenuScreen()),
      ),
    );
  }
}
