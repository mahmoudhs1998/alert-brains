import 'dart:async';

import 'package:get/get.dart';

class CountDownController extends GetxController {
  late int counter;
  final Function onCountdownFinish;

  CountDownController(this.counter, this.onCountdownFinish);

  late Timer timer;
  @override
  void onInit() {
    print('init');
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (counter > 0) {
        counter--;
        update();
      } else {
        onCountdownFinish();
        timer.cancel();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    print('kjkdhhhhhhhhhhhh');
    timer.cancel();
    super.onClose();
  }
}
