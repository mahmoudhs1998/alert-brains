import 'package:alert_brains/app.dart';
import 'package:alert_brains/constants/hive_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // FirebaseCrashlytics.instance.crash(); testing

  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.settingBox);
  print('Language_Country');
  print(Platform.localeName);
  runApp(App());
}
