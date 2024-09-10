import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager extends GetxController {
  static bool isTest = true;
  static String banner = isTest
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-2601713466894043~3814844004";
  static String Interstitial = isTest
      ? "ca-app-pub-3940256099942544/1033173712"
      : "ca-app-pub-2601713466894043~3814844004";

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  bool isLoaded = false;
  @override
  void onInit() {
    super.onInit();
    loadBannerAd();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Interstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
            if (interstitialAd != null) {
              interstitialAd!.show();
            }
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            }, onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isLoaded = true;
            update();
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: AdRequest())
      ..load();
  }
}
