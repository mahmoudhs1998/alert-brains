import 'package:alert_brains/global_presentation/game_detials_row/game_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameDetailsRow extends StatelessWidget {
  final int counter;
  final int questionNumber;
  final int trials;
  final int coins;
  const GameDetailsRow(
      {super.key,
      required this.counter,
      required this.questionNumber,
      required this.trials,
      required this.coins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GameItemRow(
            svg: 'time',
            title: counter.toString() + 's',
          ),
          GameItemRow(
            svg: 'questions',
            title: questionNumber.toString() + '/10',
          ),
          GameItemRow(
            svg: 'trials',
            title: trials.toString() + '/3',
          ),
          GameItemRow(
            svg: 'coins',
            title: coins.toString(),
          ),
        ],
      ),
    );
  }
}
