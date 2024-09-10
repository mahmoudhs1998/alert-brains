import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';

class GamesLevelModel {
  late GameDetailsModel quickMath;
  late GameDetailsModel memoPower;
  late GameDetailsModel focus;
  late GameDetailsModel speedyNumbers;

  GamesLevelModel({
    required this.quickMath,
    required this.memoPower,
    required this.focus,
    required this.speedyNumbers,
  });

  factory GamesLevelModel.fromJson(Map<dynamic, dynamic> data) {
    return GamesLevelModel(
      quickMath: GameDetailsModel.fromJson(data['quickMath']),
      memoPower: GameDetailsModel.fromJson(data['memoPower']),
      focus: GameDetailsModel.fromJson(data['focus']),
      speedyNumbers: GameDetailsModel.fromJson(data['speedyNumbers']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quickMath': quickMath.toMap(),
      'memoPower': memoPower.toMap(),
      'focus': focus.toMap(),
      'speedyNumbers': speedyNumbers.toMap(),
    };
  }
}
