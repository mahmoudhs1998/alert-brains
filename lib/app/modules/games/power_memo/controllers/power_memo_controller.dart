import 'dart:async';
import 'dart:math';
import 'package:alert_brains/app/data/cache_helper.dart';
import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/user_model.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/app/modules/games/helper/levels_screen/levels_screen.dart';
import 'package:alert_brains/app/modules/main_menu_screen/controllers/main_menu_controller.dart';
import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PowerMemoController extends GetxController {
  late GameDetailsModel gameDetailsModel;
  bool trial;
  PowerMemoController({required this.gameDetailsModel, required this.trial});

  bool start = false;
  late Timer timer;
  late int level = gameDetailsModel.level;

  // 22 333 444 55
  int questionNo = 0;
  List<int> boxesFrameSize = [9, 9, 9, 9, 9, 16, 16, 16, 25, 25];
  List<int> boxesColoredCount = [2, 2, 3, 3, 3, 4, 4, 4, 5, 5];
  Map<int, Color> boxColors = {
    2: Colors.indigoAccent,
    3: Colors.amber,
    4: Colors.cyanAccent,
    5: Colors.pinkAccent
  };
  int timeOutAfter = 10;
  late UserModel userModel;

  @override
  void onInit() async {
    userModel = UserModel.fromJson((await CacheHelper.getUser())!);
    // •	Level 01 -> Level 10      10 seconds, 9 boxes, 3 colored boxes
    // •	Level 11 -> Level 20      8 seconds, 16 boxes, 4 colored boxes
    // •	Level 21 -> Level 25      6 seconds, 16 boxes, 5 colored boxes
    // •	Level 26 -> Level 30      5 seconds, 25 boxes, 6 colored boxes

    if (!trial) {
      print(level);
      if (level >= 0 && level <= 9) {
        print('1111');
        boxesFrameSize = List.generate(10, (index) => 9);
        boxesColoredCount = List.generate(10, (index) => 3);
        timeOutAfter = 10;
      } else if (level > 9 && level <= 19) {
        boxesFrameSize = List.generate(10, (index) => 16);
        boxesColoredCount = List.generate(10, (index) => 4);
        timeOutAfter = 8;
      } else if (level > 19 && level <= 24) {
        boxesFrameSize = List.generate(10, (index) => 16);
        boxesColoredCount = List.generate(10, (index) => 5);
        timeOutAfter = 6;
      } else if (level > 24 && level <= 29) {
        boxesFrameSize = List.generate(10, (index) => 25);
        boxesColoredCount = List.generate(10, (index) => 6);
        timeOutAfter = 5;
      }
    }
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

  Future<void> startGame() async {
    if (closed) return;
    start = true;
    Get.delete<CountDownController>();
    _resetGameFields();
    update();
    await Future.delayed(Duration(milliseconds: 500));
    await _createQuestion();
    await Future.delayed(Duration(seconds: 3));
    emptyFrame();
    _makeUserSelect();
  }

  _resetGameFields() {
    boxClickable = false;
    questionNumbers.clear();
    _questionNumberCopy.clear();
  }

  List<int> questionNumbers = [];
  List<int> _questionNumberCopy = [];
  Future<void> _createQuestion() async {
    if (closed) return;
    Random random = new Random();
    while (questionNumbers.length < boxesColoredCount[questionNo]) {
      int randomNumber = random.nextInt(boxesFrameSize[questionNo]);
      print(randomNumber);
      if (!questionNumbers.contains(randomNumber)) {
        questionNumbers.add(randomNumber);
        update();
        await Future.delayed(Duration(milliseconds: 500));
      }
    }
    _questionNumberCopy = List.of(questionNumbers);
  }

  emptyFrame() {
    questionNumbers.clear();
    update();
  }

  bool boxClickable = false;
  late int timeOutCounter = timeOutAfter;
  _makeUserSelect() {
    if (closed) return;
    timeOutCounter = timeOutAfter;
    boxClickable = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timeOutCounter--;
      if (timeOutCounter == 0) {
        timer.cancel();
        _showTimeOut();
      }
      update();
    });
  }

  _showTimeOut() {
    showDefaultDialog(
        title: 'Time',
        content: 'Time out!',
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
      UserRepository.updateGameTrial(GamesType.memo);
      await showDefaultDialog(
          title: 'Trial', content: 'Done :)', btnTitle: 'close');
      Get.off(() => LevelScreenOfGames(
            containerColor: Color(0xffF8E3B5),
            appBarButtonColor: Color(0xffF8E3B5),
            appBarTitle: 'Power Memo',
            gameType: GamesType.memo,
          ));
    } else {
      UserRepository.updateGameLevel(++level, GamesType.memo);
      Get.find<MainMenuController>().userModel.gamesLevelModel.memoPower.level =
          level;
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
                    appBarTitle: 'Power Memo',
                    gameType: GamesType.memo,
                  ),
                ),
                (route) => route.isFirst);
          });
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

  checkUserSelection(int index) async {
    if (_questionNumberCopy.contains(index)) {
      questionNumbers.add(index);
      update();
      if (questionNumbers.length == _questionNumberCopy.length) {
        await Future.delayed(Duration(seconds: 1));
        timer.cancel();
        if (questionNo == 9) {
          _showLevelDone();
          return;
        }
        questionNo++;
        startGame();
      }
    } else {
      questionNumbers = List.of(_questionNumberCopy);
      questionNumbers.add(index);
      update();
      await Future.delayed(Duration(seconds: 1));
      _showWrongAnswer();
      timer.cancel();
    }
  }

  _restartGame() {
    Get.back();
    start = false;
    questionNo = 0;
    update();
  }

  bool isRightAnswer(int index) {
    if (!boxClickable || _questionNumberCopy.contains(index)) {
      return true;
    }
    return false;
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
