import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constant.dart';
import '../controllers/tic_tac_toe.dart';
import '../layout/layout.dart';
import '../utils/config.dart';
import '../widgets/button.dart';
import '../widgets/cubes.dart';
import '../widgets/scoreboard.dart';

class XoView extends StatefulWidget {
  const XoView({Key? key}) : super(key: key);

  @override
  State<XoView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<XoView> {
  final TicTacToeController ticTacToeController =
      Get.put(TicTacToeController());

  @override
  void initState() {
    super.initState();
    ticTacToeController.onResetClick();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<TicTacToeController>(builder: (_) {
      return CustomLayout(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 7),
                child: ScoreboardWidget(
                  xScore: ticTacToeController.xScore,
                  yScore: ticTacToeController.oScore,
                ),
              ),
              for (var i = 0; i < 3; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var j = 0; j < 3; j++)
                      GestureDetector(
                          onTap: () {
                            ticTacToeController.onUserClick(i, j);
                          },
                          child: ColorFiltered(
                            colorFilter:
                            ticTacToeController.movesMade.value > 5 &&
                            ticTacToeController.iIndexToRemove.value == i && ticTacToeController.jIndexToRemove.value == j ?
                            ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken) :
                            ColorFilter.mode(Colors.black.withOpacity(0.0), BlendMode.darken),
                            child: CubesWidget(
                              i: i,
                              j: j,
                              displayElement: ticTacToeController.data[i][j],
                            ),
                          ))
                  ],
                ),
              Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
                  child: ButtonWidget(
                      onPressed: () => {ticTacToeController.onNewGameClick()},
                      text: Constants.newGameText)),
              Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.4),
                  child: ButtonWidget(
                      onPressed: () => {ticTacToeController.onResetClick()},
                      text: Constants.resetGameText))
            ],
          ),
        ),
      );
    });
  }
}
