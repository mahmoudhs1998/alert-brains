import 'dart:async';
import 'dart:math';

import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/count_down/controllers/count_down_controller.dart';
import 'package:alert_brains/app/modules/main_menu_screen/controllers/main_menu_controller.dart';
import 'package:alert_brains/global_presentation/show_default_dialog.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../helper/levels_screen/levels_screen.dart';

class MathGameController extends GetxController {
  final bool trial;
  late GameDetailsModel gameDetailsModel;
  MathGameController(this.trial, this.gameDetailsModel);
  late int level = gameDetailsModel.level;

  List<int> questionNumbers = [];
  int numberLength = 0;
  int correctAnswer = 0;
  List<int> options = <int>[];
  int seconds = 0;
  final RxInt secondsRemaining = 0.obs; // Timer duration in seconds
  Timer? timer;
  final RxInt questionNumber = 0.obs; // Track the current question number
  late String operationSymbol; // To store the operation symbol (+ or -)
  bool start = false;

  @override
  void onInit() async {
    // •	Questions per Level: 10
    // •	Level 01 -> Level 10      10 seconds, 2 numbers
    // •	Level 11 -> Level 20      8 seconds, 3 numbers
    // •	Level 21 -> Level 25      4 seconds, 4 numbers
    // •	Level 26 -> Level 30      2 seconds, 5 numbers

    if (level >= 0 && level <= 9) {
      numberLength = 2;
      seconds = secondsRemaining.value = 10;
    } else if (level > 9 && level <= 19) {
      numberLength = 3;
      seconds = secondsRemaining.value = 8;
    } else if (level > 19 && level <= 24) {
      numberLength = 4;
      seconds = secondsRemaining.value = 4;
    } else if (level > 24 && level <= 29) {
      numberLength = 5;
      seconds = secondsRemaining.value = 2;
    }

    super.onInit();
  }

  void restartGame() {
    start = false;
    update();
    // Reset all game-related variables
    questionNumbers.clear();
    correctAnswer = 0;
    options.clear();
    secondsRemaining.value = 15;
    questionNumber.value = 0;
  }

  void generateQuestion() {
    correctAnswer = 0;
    final Random random = Random();
    questionNumber.value++; // Increment the question number
    questionNumbers =
        List.generate(numberLength, (index) => random.nextInt(9) + 1);
    // Randomly choose between addition and subtraction
    bool isAddition = random.nextBool();

    if (isAddition) {
      questionNumbers.forEach((element) {
        print(correctAnswer);
        print(element);
        correctAnswer += element;
      });
      operationSymbol = '+';
    } else {
      for (int i = 0; i < questionNumbers.length; i++) {
        print(correctAnswer);
        print(questionNumbers[i]);

        if (i == 0) {
          correctAnswer += questionNumbers[i];
        } else {
          correctAnswer -= questionNumbers[i];
        }
      }
      operationSymbol = '-';
    }

    options = [
      correctAnswer,
      correctAnswer - 1,
      correctAnswer + 1,
      correctAnswer + 2,
    ];
    print('answer');
    print(correctAnswer);
    options.shuffle();
    startTimer(); // Start the timer after generating a new question
  }

  void startTimer() async {
    timer = Timer.periodic(Duration(seconds: 1), (v) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer?.cancel();
        UserRepository.updateGameTrials(GamesType.quickMath, true);
        showTimeUpDialog();
      }
    });
  }

  void showTimeUpDialog() {
    showDefaultDialog(
      btnTitle: 'Restart',
      onMainButtonPressed: () {
        if (UserRepository.userModel.gamesLevelModel.quickMath.trials > 0 || trial) {
          Get.back(); // Close the dialog
          restartGame();
        } else {
          Get.close(2);
        }
      },
      imagePath: 'assets/images/timeUpGreen.png',
      dialogText: 'Time\'s Up! You ran out of time.',
      buttonColor: AppColors.green,
      buttonBorderColor: AppColors.green,
      mainButtonText: 'Restart',
    );
  }

  void startGame() {
    start = true;
    update();
    Get.delete<CountDownController>();
    generateQuestion();
  }

  void checkAnswer(int selectedAnswer) {
    timer?.cancel();
    if (selectedAnswer == correctAnswer) {
      // If answer is correct, generate next question
      secondsRemaining.value = seconds;
      if (questionNumber == 10) {
        showLevelDone();
        return;
      }
      generateQuestion();
    } else {
      UserRepository.updateGameTrials(GamesType.quickMath, true);
      showWrongDialog();
    }
  }

  showLevelDone() {
    timer?.cancel();
    if (trial) {
      UserRepository.updateGameTrial(GamesType.quickMath);
      Get.find<MainMenuController>().trialModel.quickMath = true;
      showDefaultDialog(
          onBackButtonPressed: () {},
          onMainButtonPressed: () {
            Get.back();
            Get.off(LevelScreenOfGames(
              containerColor: Color(0xFFCAE5BD),
              appBarButtonColor: Color(0xFFCAE5BD),
              appBarTitle: 'Quick Math',
              gameType: GamesType.quickMath,
            )); // Update the title},
          },
          btnTitle: 'asd',
          imagePath: 'assets/images/Congratulations.png',
          dialogText: 'Congratulations You answered correctly.',
          buttonColor: AppColors.green,
          buttonBorderColor: AppColors.green,
          mainButtonText: 'Go Play');
    } else {
      UserRepository.updateGameLevel(++level, GamesType.quickMath);
      Get.find<MainMenuController>().userModel.gamesLevelModel.quickMath.level =
          level;
      showDefaultDialog(
          onBackButtonPressed: () {},
          onMainButtonPressed: () {
            if (level > 30) {
              Get.close(3);
              return;
            }
            Get.close(2);
            Get.offUntil(
                MaterialPageRoute(
                  builder: (context) => LevelScreenOfGames(
                    containerColor: Color(0xFFCAE5BD),
                    appBarButtonColor: Color(0xFFCAE5BD),
                    appBarTitle: 'Quick Math',
                    gameType: GamesType.quickMath,
                  ),
                ),
                (route) => route.isFirst); // Update the title},
          },
          btnTitle: 'asd',
          imagePath: 'assets/images/Congratulations.png',
          dialogText: 'Congratulations You answered correctly.',
          buttonColor: AppColors.green,
          buttonBorderColor: AppColors.green,
          mainButtonText: 'Continue');
    }
  }

  void showWrongDialog() {
    showDefaultDialog(
      onBackButtonPressed: () {
        Get.until((route) => route.isFirst);
      },
      onMainButtonPressed: () {
        if (UserRepository.userModel.gamesLevelModel.quickMath.trials > 0 || trial) {
          Get.back(); // Close the dialog
          restartGame();
        } else {
          Get.close(2);
        }
      },
      btnTitle: 'Restart',
      imagePath: 'assets/images/mistakeGreen.png',
      dialogText: 'Wrong Answer! You answered wrong.',
      buttonColor: AppColors.green,
      buttonBorderColor: AppColors.green,
      mainButtonText: 'Restart',
    );
  }

  @override
  void onClose() {
    timer?.cancel(); // Dispose the timer to prevent memory leaks
    super.onClose();
  }

  @override
  void dispose() {
    timer?.cancel(); // Dispose the timer to prevent memory leaks
    super.dispose();
  }

  String getQuestionBody() {
    String questionBody = '';
    for (int i = 0; i < questionNumbers.length; i++) {
      questionBody += " ${questionNumbers[i]}";
      if (i != questionNumbers.length - 1) {
        questionBody += " ${operationSymbol}";
      }
    }
    return questionBody + " ?";
  }
}
