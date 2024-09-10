import 'package:alert_brains/app/modules/gifts/view/widgets/gift_card.dart';
import 'package:alert_brains/constants/app_colors.dart';
import 'package:alert_brains/global_presentation/build_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
          child: BuildBackIcon(
            color: AppColors.green,
          ),
        ),
        title: Text("Gift"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          10,
          (index) => GiftCard(
            title: "Gift $index",
            backgroundColor: AppColors.whiteGreen, // Change as needed
            imagePath: "assets/images/gift.svg", // Example URL
          ),
        ),
      ),
    );
  }
}
