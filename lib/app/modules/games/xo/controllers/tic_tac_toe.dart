import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';
import '../utils/util.dart';
import '../widgets/button.dart';

class TicTacToeController extends GetxController {
  final RxString currentDisplayElement = 'X'.obs;
  final RxList<List<String>> data = List.generate(3, (_) => List.filled(3, '')).obs;
  final RxInt xScore = 0.obs;
  final RxInt oScore = 0.obs;
  final RxBool stopInteraction = false.obs;

  final int maxMarks = 3; // Maximum number of marks per player
  final List<List<List<int>>> playerMovesHistory = List.generate(2, (_) => List.filled(3, [], growable: true), growable: true);
  final RxInt iIndexToRemove = 0.obs;
  final RxInt jIndexToRemove = 0.obs;
  final RxInt movesMade = 0.obs;
  // functions
  // Open dialog if anyone won game
  void openGetXDialog(String displayElement) {
    Get.defaultDialog(
      title: displayElement == 'draw'
          ? "''DRAW''"
          : "''$displayElement'' won !!",
      middleText: Constants.dialogMiddleText,
      backgroundColor: Constants.backgroundColor,
      titleStyle: const TextStyle(
        color: Constants.whiteColor,
        fontFamily: Constants.fontFamily,
        fontWeight: FontWeight.w600,
      ),
      middleTextStyle: const TextStyle(
        color: Constants.whiteColor,
        fontFamily: Constants.fontFamily,
      ),
      confirm: ButtonWidget(
        width: 140,
        height: 40,
        onPressed: () {
          onResetClick();
          Get.back(closeOverlays: true);
        },
        text: Constants.resetButtonText,
      ),
      barrierDismissible: false,
      radius: 8,
    );
  }

  // when user clicks on block
  void onUserClick(int i, int j) {
    if (data[i][j] != '' || stopInteraction.value) return;

    // Update move history for the current player
    final currentPlayerIndex = currentDisplayElement.value == 'X' ? 0 : 1;
    playerMovesHistory[currentPlayerIndex].add([i, j]);
    if (playerMovesHistory[currentPlayerIndex].length > maxMarks) {
      final oldestMove = playerMovesHistory[currentPlayerIndex].removeAt(0);
      data[oldestMove[0]][oldestMove[1]] = '';
    }

    data[i][j] = currentDisplayElement.value;

    String winner = Util.calculateWinner(data);
    if (winner == 'X') {
      xScore.value++;
      stopInteraction.value = true;
      openGetXDialog(winner);
    } else if (winner == 'O') {
      oScore.value++;
      stopInteraction.value = true;
      openGetXDialog(winner);
    } else if (winner == 'draw') {
      openGetXDialog(winner);
    } else {
      // Switch to the next player
      currentDisplayElement.value = currentDisplayElement.value == 'X' ? 'O' : 'X';

      // Check if it's the computer's turn and make its move
      if (currentDisplayElement.value == 'O') {
        computerMove(); // Trigger the computer's move
      }

    }
    final indexToRemove = getNextIndexToRemove();
    if (indexToRemove != null) {
      iIndexToRemove.value = indexToRemove[0];
      jIndexToRemove.value = indexToRemove[1];
    }
    movesMade.value++;
    update();
  }

  // Get the index to be removed for the next move
  List<int>? getNextIndexToRemove() {
    final currentPlayerIndex = currentDisplayElement.value == 'X' ? 0 : 1;
    if (playerMovesHistory[currentPlayerIndex].length < maxMarks) {
      return null; // No index to remove if the maximum marks haven't been reached yet
    } else {
      return playerMovesHistory[currentPlayerIndex].first;
    }
  }

  // when new game is clicked
  void onNewGameClick() {
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[i].length; j++) {
        data[i][j] = '';
      }
    }
    xScore.value = 0;
    oScore.value = 0;
    currentDisplayElement.value = 'X';
    stopInteraction.value = false;
    playerMovesHistory.forEach((playerMoves) => playerMoves.clear());
    movesMade.value = 0;
    update();
  }

  // when reset game is clicked
  void onResetClick() {
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[i].length; j++) {
        data[i][j] = '';
      }
    }
    currentDisplayElement.value = 'X';
    stopInteraction.value = false;
    playerMovesHistory.forEach((playerMoves) => playerMoves.clear());
    movesMade.value = 0;
    update();
  }


  // Minimax algorithm to determine the best move for the computer
  int minimax(List<List<String>> board, int depth, bool isMaximizing) {
    String result = Util.calculateWinner(board);
    if (result == 'X') {
      return -10;
    } else if (result == 'O') {
      return 10;
    } else if (result == 'draw') {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board[i].length; j++) {
          if (board[i][j] == '') {
            board[i][j] = 'O';
            int score = minimax(board, depth + 1, false);
            board[i][j] = '';
            bestScore = max(score, bestScore);
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board[i].length; j++) {
          if (board[i][j] == '') {
            board[i][j] = 'X';
            int score = minimax(board, depth + 1, true);
            board[i][j] = '';
            bestScore = min(score, bestScore);
          }
        }
      }
      return bestScore;
    }
  }

  List<int> findBestMove(List<List<String>> board) {
    int bestScore = -1000;
    List<int> bestMove = [-1, -1];

    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (board[i][j] == '') {
          board[i][j] = 'O';
          int score = minimax(board, 0, false);
          board[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
    }

    return bestMove;
  }

  // Computer's move
  void computerMove() {

    List<int> bestMove = findBestMove(data);
    int i = bestMove[0];
    int j = bestMove[1];

    if (data[i][j] == '') {
      onUserClick(i, j);
    }
  }


}
