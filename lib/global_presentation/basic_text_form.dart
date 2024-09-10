import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableTextField extends StatelessWidget {
  final double width;
  final String hintText;
  final String labelText;
  final BorderRadius borderRadius;
  final Color borderColor;
  final TextEditingController controller;

  const ReusableTextField({
    super.key,
    required this.width,
    required this.hintText,
    required this.borderRadius,
    this.borderColor = Colors.white,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            label: Text(
              labelText,
              style: TextStyle(fontSize: 16.sp),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
