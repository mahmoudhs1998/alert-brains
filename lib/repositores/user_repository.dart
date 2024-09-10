import 'package:alert_brains/app/data/cache_helper.dart';
import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/games_level_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/trial_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/user_model.dart';
import 'package:alert_brains/global_presentation/show_snack_bar.dart';

class UserRepository {
  static late UserModel userModel;

  static Future<void> loadUserData() async {
    userModel = UserModel.fromJson((await CacheHelper.getUser())!);
  }

  static updateGameLevel(int level, GamesType gameType) async {
    userModel.coins += 10;
    switch (gameType) {
      case GamesType.focus:
        if (level > userModel.gamesLevelModel.focus.level)
          userModel.gamesLevelModel.focus.level = level;
        break;
      case GamesType.memo:
        if (level > userModel.gamesLevelModel.memoPower.level)
          userModel.gamesLevelModel.memoPower.level = level;
        break;
      case GamesType.quickMath:
        if (level > userModel.gamesLevelModel.quickMath.level)
          userModel.gamesLevelModel.quickMath.level = level;
        break;
      case GamesType.speedyNumbers:
        if (level > userModel.gamesLevelModel.speedyNumbers.level)
          userModel.gamesLevelModel.speedyNumbers.level = level;
        break;
    }
    await CacheHelper.setUser(userModel.toMap());
  }

  static updateGameTrials(GamesType gameType, bool remove) async {
    switch (gameType) {
      case GamesType.focus:
        userModel.gamesLevelModel.focus.trials += (remove ? -1 : 3);
        break;
      case GamesType.memo:
        userModel.gamesLevelModel.memoPower.trials += (remove ? -1 : 3);
        break;
      case GamesType.quickMath:
        userModel.gamesLevelModel.quickMath.trials += (remove ? -1 : 3);
        break;
      case GamesType.speedyNumbers:
        userModel.gamesLevelModel.speedyNumbers.trials += (remove ? -1 : 3);
        break;
    }
    if (!remove) {
      userModel.coins -= 5;
      showSnackBar('Trials are Refilled Successfully');
    }
    await CacheHelper.setUser(userModel.toMap());
  }

  static updateUserCoins() async {
    userModel.coins += 5;
    await CacheHelper.setUser(userModel.toMap());
    showSnackBar('5 Coins are added to your Coins');
  }

  static updateGameTrial(GamesType gameType) async {
    TrialModel trialModel = await CacheHelper.getTrial();
    switch (gameType) {
      case GamesType.focus:
        trialModel.focusGame = true;
        break;
      case GamesType.memo:
        trialModel.powerMemo = true;
        break;
      case GamesType.quickMath:
        trialModel.quickMath = true;
        break;
      case GamesType.speedyNumbers:
        trialModel.speedyNumbers = true;
        break;
    }
    await CacheHelper.setTrial(trialModel);
  }

  static GameDetailsModel getGameDetailsModel(GamesType gameType) {
    GamesLevelModel gamesLevelModel = userModel.gamesLevelModel;
    switch (gameType) {
      case GamesType.focus:
        return gamesLevelModel.focus;
      case GamesType.memo:
        return gamesLevelModel.memoPower;
      case GamesType.quickMath:
        return gamesLevelModel.quickMath;
      case GamesType.speedyNumbers:
        return gamesLevelModel.speedyNumbers;
    }
  }
}

enum GamesType { focus, memo, quickMath, speedyNumbers }
