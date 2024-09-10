import 'package:alert_brains/app/modules/auth/data/models/trial_model.dart';
import 'package:alert_brains/constants/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheHelper {
  CacheHelper._();

  static Future<void> setUser(Map userMap) async {
    String userBoxKey = HiveKeys.currentUserBox;
    await Hive.openBox(userBoxKey);
    final userBox = Hive.box(userBoxKey);

    await userBox.put(HiveKeys.userModel, userMap);
  }

  static Future<Map?> getUser() async {
    String userBoxKey = HiveKeys.currentUserBox;
    await Hive.openBox(userBoxKey);
    final userBox = Hive.box(userBoxKey);

    return userBox.get(HiveKeys.userModel);
  }

  static Future<void> setTrial(TrialModel trialModel) async {
    String trialBoxKey = HiveKeys.currentUserBox;
    await Hive.openBox(trialBoxKey);
    final trialBox = Hive.box(trialBoxKey);

    await trialBox.put(HiveKeys.trialModel, trialModel.toMap());
  }

  static Future<TrialModel> getTrial() async {
    String trialBoxKey = HiveKeys.currentUserBox;
    final trialBox = await Hive.openBox(trialBoxKey);

    if (trialBox.get(HiveKeys.trialModel) == null) {
      await setTrial(TrialModel(false, false, false, false));
    }

    var trialMap = trialBox.get(HiveKeys.trialModel) as Map;
    return TrialModel.fromJson(trialMap.cast<String, dynamic>());
  }
}
