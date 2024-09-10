import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameItemRow extends StatelessWidget {
  final String svg;
  final String title;
  const GameItemRow({super.key, required this.svg, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/$svg.svg',
          height: 20.h,
          width: 20.h,
        ),
        SizedBox(width: 5.w,),
        BuildText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        )
      ],
    );
  }
}
