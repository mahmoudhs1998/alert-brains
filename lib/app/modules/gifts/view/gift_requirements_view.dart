import 'package:alert_brains/app/modules/gifts/view/widgets/gift_card.dart';
import 'package:alert_brains/constants/app_colors.dart';
import 'package:alert_brains/global_presentation/basic_text_form.dart';
import 'package:alert_brains/global_presentation/build_back_icon.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftRequirementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController doc = TextEditingController();
    TextEditingController address = TextEditingController();
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildText(
                text: "Get the gift",
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 40.h,
              ),
              ReusableTextField(
                width: double.infinity,
                hintText: 'Governorate',
                borderRadius: BorderRadius.circular(30),
                controller: doc,
                labelText: 'gov',
              ),
              SizedBox(
                height: 10.h,
              ),
              ReusableTextField(
                width: double.infinity,
                hintText: 'Address',
                borderRadius: BorderRadius.circular(30),
                controller: address,
                labelText: 'Address',
              ),
            ],
          ),
        ));
  }
}
