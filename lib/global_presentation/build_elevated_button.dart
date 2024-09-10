import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color color;
  final Color? textColor;
  final double? borderRadius;
  final Widget? widget;
  const BuildElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.color,
    this.textColor,
    this.widget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((borderRadius ?? 20.0).sp),
          ))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget != null) widget!,
          BuildText(
            text: title,
            fontSize: 15,
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
