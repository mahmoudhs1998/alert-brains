// settings_view.dart
import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/settings_screen/controllers.dart';
import 'package:alert_brains/global_presentation/build_image_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global_presentation/build_back_icon.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(13.0),
          child: BuildBackIcon(
            color: AppColors.green,
          ),
         
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteGrey,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          buildSettingItem(
            icon: 'assets/images/profile.png',
            title: "Profile",
            subtitle: "Make changes to your profile", 
            onTap: () => controller.goToProfile(),
          ),
          const Divider(),
          buildSettingItem(
            icon: 'assets/images/language.png',
            title: "Language",
            subtitle: "Choose your native language", 
            onTap: () => controller.goToLanguageScreen(),
          ),
          const Divider(),
          buildSettingItem(
            icon: Icons.star_rounded,
            title: "Review Our App",
            subtitle: "Review Our App on play store", 
            onTap: () => controller.reviewApp(),
          ),
          const Divider(),
          buildSettingItem(
            icon: 'assets/images/logout.png',
            title: "Log out",
            subtitle: "Log out your account",
            onTap: () => controller.logOut(),
          ),
        ],
      ),

    );
  }

  Widget buildSettingItem({
    required dynamic icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: icon is String
                  ? ReusableFractionallySizedBox(
                      widthFactor: 0.9.w,
                      imagePath: icon,
                    )
                  : Icon(icon, size: 30.sp, color: AppColors.green),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20.sp, color: AppColors.whiteGrey),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.whiteGrey),
                ),
              ],
            ),
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: Icon(Icons.arrow_forward_ios_rounded,
                  size: 30.sp, color: AppColors.green),
            ),
          ],
        ),
      ),
    );
  }
}
