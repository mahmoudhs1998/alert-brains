import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message) {
  final snackBar = SnackBar(
    content: BuildText(text: message),
  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}
