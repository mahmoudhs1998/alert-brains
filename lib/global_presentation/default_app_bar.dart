import 'package:alert_brains/global_presentation/build_back_icon.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final String title;
  const DefaultAppBar({super.key, this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.mediaQuery.padding.top + 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: SizedBox(
                width: 25.w,
                child: BuildBackIcon(
                  color: color,
                ),
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          BuildText(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: 45.w,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      Theme.of(Get.context!).appBarTheme.toolbarHeight ?? kToolbarHeight);
}
