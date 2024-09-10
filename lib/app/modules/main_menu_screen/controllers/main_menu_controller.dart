import 'package:alert_brains/app/data/cache_helper.dart';
import 'package:alert_brains/app/modules/auth/data/models/trial_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/user_model.dart';
import 'package:alert_brains/app/modules/main_menu_screen/data/repos/main_menu_repo.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MainMenuController extends GetxController {
  RxBool dataLoaded = false.obs;
  late UserModel userModel;
  late TrialModel trialModel;

  @override
  void onInit() async {
    MainMenuRepo mainMenuRepo = MainMenuRepo();

    Map userFirebase = await mainMenuRepo.getCurrentUser();
    print('firebase');
    print(userFirebase);

    Map userHive = (await CacheHelper.getUser())!;
    print('hive');
    print(userHive);

    bool isUserUpdated = _compareMaps(Map.of(userFirebase), Map.of(userHive));
    print('updated');
    print(isUserUpdated);
    if (!isUserUpdated) {
      await mainMenuRepo.updateCurrentUser(userHive);
    }

    userModel = UserModel.fromJson(userHive);
    trialModel = await CacheHelper.getTrial();
    print('GamesType');
    print(trialModel.toMap());

    dataLoaded.value = true;
    await UserRepository.loadUserData();
    super.onInit();
  }

  int getCurrentGamePlayedPercent(GamesType gameType) {
    int currentLevel = 0;
    switch (gameType) {
      case GamesType.focus:
        currentLevel = userModel.gamesLevelModel.focus.level;
        break;
      case GamesType.memo:
        currentLevel = userModel.gamesLevelModel.memoPower.level;
        print(currentLevel);
        break;
      case GamesType.quickMath:
        currentLevel = userModel.gamesLevelModel.quickMath.level;
        break;
      case GamesType.speedyNumbers:
        currentLevel = userModel.gamesLevelModel.speedyNumbers.level;
        break;
    }
    return (currentLevel / 30 * 100).toInt();
  }
}

_compareMaps(Map firebaseMap, Map hiveMap) {
  Map firebaseGameLevels = Map.of(firebaseMap['gamesLevelModel']);
  Map hiveGameLevels = Map.of(hiveMap['gamesLevelModel']);

  firebaseMap['gamesLevelModel'] = null;
  hiveMap['gamesLevelModel'] = null;

  bool userMapEqual = mapEquals(firebaseMap, hiveMap);
  bool gameMapEqual = mapEquals(firebaseGameLevels, hiveGameLevels);

  return gameMapEqual & userMapEqual;
}
