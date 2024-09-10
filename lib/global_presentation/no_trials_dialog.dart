import 'package:alert_brains/app/modules/games/power_memo/controllers/power_memo_controller.dart';
import 'package:alert_brains/app/modules/main_menu_screen/controllers/main_menu_controller.dart';
import 'package:alert_brains/repositores/user_repository.dart';
import 'package:alert_brains/services/ads_manager/ads_manager_controller.dart';
import 'package:get/get.dart';

showNoTrialsDialog(GamesType gameType) {
  int coins = Get.find<MainMenuController>().userModel.coins;

  if (coins >= 5) {
    showDefaultDialog(
        title: 'No More Trials',
        content: 'U must refill by using coins to be able to continue',
        btnTitle: 'Refill',
        onPressed: () {
          Get.back();
          UserRepository.updateGameTrials(gameType, false);
        });
  } else {
    showDefaultDialog(
        title: 'No More Trials',
        content: 'U must watch a video to get 5 coins and refill by them',
        btnTitle: 'Watch',
        onPressed: () async {
          Get.back();

          /// show video here instead of that
          /// make the new add future<bool> and assign value to variable like that
          /// bool adShown = await Get.find<AdManager>().showRewardAd();
          /// after that use adShown to check if user show the add
          /// if(adShown)
          /// UserRepository.updateGameTrials(gameType, false);
          Get.find<AdManager>().loadInterstitialAd();
          UserRepository.updateUserCoins();
        });
  }
}
