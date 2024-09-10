import 'dart:async';
import 'dart:math';

import 'package:alert_brains/Constants/app_colors.dart';
import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/app/modules/games/helper/levels_screen/levels_screen.dart';
import 'package:alert_brains/app/modules/main_menu_screen/controllers/main_menu_controller.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/cache_helper.dart';
import '../../../auth/data/models/user_model.dart';

class SpeedyNumberController extends GetxController
    with WidgetsBindingObserver {
  final bool trial;
  late GameDetailsModel gameDetailsModel;

  late int level = gameDetailsModel.level;
  List<int> questionNumbers = [];
  late Timer timer;
  int timeOutAfter = 10;
  int questionsLength = 10;
  int questionNo = 0;
  late UserModel userModel;
  TextEditingController textEditingController = TextEditingController();

  SpeedyNumberController({required this.trial, required this.gameDetailsModel});

  // just to show different color may be two numbers are identical come one after other
  late List<Color> colors;

  bool start = false;

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    userModel = UserModel.fromJson((await CacheHelper.getUser())!);
    if (!trial) {
      print(level);
      // •	Level 01 -> Level 10      5 seconds, 15 number
      // •	Level 11 -> Level 20      4 seconds, 15 number
      // •	Level 21 -> Level 25      3 seconds, 15 number
      // •	Level 26 -> Level 30      2 seconds, 20 number
      if (level >= 0 && level <= 9) {
        timeOutAfter = 5;
        questionsLength = 15;
      } else if (level > 9 && level <= 19) {
        timeOutAfter = 4;
        questionsLength = 15;
      } else if (level > 19 && level <= 24) {
        timeOutAfter = 3;
        questionsLength = 15;
      } else if (level > 24 && level <= 29) {
        timeOutAfter = 2;
        questionsLength = 20;
      }
    }
    colors = List.generate(
        questionsLength,
        (index) => index.isEven || index == 0
            ? AppColors.primaryPurple
            : AppColors.green);
    super.onInit();
  }

  bool closed = false;

  @override
  void onClose() {
    try {
      timer.cancel();
    } catch (_) {}
    closed = true;
    super.onClose();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void startGame() {
    if (closed) return;
    start = true;
    Get.delete<CountDownController>();
    _resetGameFields();
    update();
    _createQuestion();
  }

  bool hideQuestion = false;
  void _createQuestion() {
    if (closed) return;
    hideQuestion = false;
    Random random = Random();
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      int randomValue = random.nextInt(11) * (random.nextBool() ? -1 : 1);
      questionNumbers.add(randomValue);
      update();
      if (questionNumbers.length == questionsLength) {
        timer.cancel();
        await Future.delayed(Duration(seconds: 1));
        hideQuestion = true;
        update();
        _makeUserSelect();

        /// remove
        int answer = 0;
        questionNumbers.forEach((element) {
          answer += element;
          print('answer');
          print(answer);
        });
      }
    });
    questionNo++;
  }

  void _resetGameFields() {
    questionNumbers.clear();
    questionNumbers.clear();
    timeOutCounter = timeOutAfter;
    textEditingController.clear();
    _waitingAnswer = false;
  }

  void _restartGame() {
    Get.back();
    start = false;
    questionNo = 0;
    questionNumbers.clear();
    timeOutCounter = timeOutAfter;
    update();
  }

  late int timeOutCounter = timeOutAfter;
  _makeUserSelect() {
    if (closed) return;
    timeOutCounter = timeOutAfter;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timeOutCounter--;
      if (timeOutCounter == 0) {
        timer.cancel();
        _showTimeOut();
      }
      update();
    });
  }

  void _showTimeOut() {
    showDefaultDialog(
        title: 'Time',
        content: 'Time out!',
        btnTitle: 'restart',
        onPressed: () {
          _restartGame();
        });
  }

  void checkUserAnswer() {
    String userAnswer = textEditingController.text;
    print('userAnswer');
    print(userAnswer);
    int answer = 0;
    questionNumbers.forEach((element) {
      answer += element;
    });
    print('answer');
    print(answer);
    if (int.tryParse(userAnswer) != null && answer == int.parse(userAnswer)) {
      if (questionNo == 10) {
        _showLevelDone();
        return;
      }
      startGame();
    } else {
      _showWrongAnswer();
    }
  }

  _showWrongAnswer() {
    showDefaultDialog(
        title: 'Answer',
        content: 'wrong :(',
        btnTitle: 'restart',
        onPressed: () {
          _restartGame();
        });
  }

  _showLevelDone() async {
    print('trial');
    print(trial);
    if (trial) {
      Get.find<MainMenuController>().trialModel.powerMemo = true;
      UserRepository.updateGameTrial(GamesType.speedyNumbers);
      await showDefaultDialog(
          title: 'Trial', content: 'Done :)', btnTitle: 'close');
      Get.off(() => LevelScreenOfGames(
            containerColor: Color(0xffF8E3B5),
            appBarButtonColor: Color(0xffF8E3B5),
            appBarTitle: 'Speedy Numbers',
            gameType: GamesType.speedyNumbers,
          ));
    } else {
      UserRepository.updateGameLevel(++level, GamesType.speedyNumbers);
      Get.find<MainMenuController>()
          .userModel
          .gamesLevelModel
          .speedyNumbers
          .level = level;
      await showDefaultDialog(
          title: 'Level',
          content: 'Done :)',
          btnTitle: 'close',
          onPressed: () {
            if (level > 30) {
              Get.close(3);
              return;
            }
            Get.close(2);
            Get.offUntil(
                MaterialPageRoute(
                  builder: (context) => LevelScreenOfGames(
                    containerColor: Color(0xffF8E3B5),
                    appBarButtonColor: Color(0xffF8E3B5),
                    appBarTitle: 'Speedy Numbers',
                    gameType: GamesType.speedyNumbers,
                  ),
                ),
                (route) => route.isFirst);
          });
    }
  }

  bool _waitingAnswer = false;
  stopTimerWhenUserOpenKeyBoard() {
    timer.cancel();
    _waitingAnswer = true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state');
    print(state);
    if (state == AppLifecycleState.inactive && _waitingAnswer) {
      Get.back();
      WidgetsBinding.instance.removeObserver(this);
    }
    super.didChangeAppLifecycleState(state);
  }
}

Future<void> showDefaultDialog(
    {required String title,
    required String content,
    required String btnTitle,
    void Function()? onPressed}) async {
  await Get.defaultDialog(
    title: title,
    middleText: content,
    actions: [
      ElevatedButton(
        onPressed: onPressed ??
            () {
              Get.back();
            },
        child: BuildText(text: btnTitle),
      ),
    ],
  );
}
