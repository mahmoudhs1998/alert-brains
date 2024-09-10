import 'package:alert_brains/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? style;
  final TextAlign? textAlign;
  const BuildText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.style,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? AppColors.textColor,
            fontFamily: 'DM Mono',
            fontSize: (fontSize ?? 14).sp,
          ),
      textAlign: textAlign,
    );
  }
}
