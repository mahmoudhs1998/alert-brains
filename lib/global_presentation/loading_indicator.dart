import 'package:alert_brains/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicator({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? GFLoader(
          size: 60.h,
          loaderColorOne: AppColors.primaryPurple,
          loaderColorTwo: AppColors.secondaryYellow,
          loaderColorThree: AppColors.green,
          type: GFLoaderType.circle)
          : const SizedBox.shrink(),
    );
  }
}
