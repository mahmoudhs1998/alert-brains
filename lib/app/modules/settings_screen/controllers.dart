// settings_controller.dart
import 'package:alert_brains/app/modules/auth/views/auth_view.dart';
import 'package:alert_brains/app/modules/language_screen/language_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class SettingsController extends GetxController {

  void goToProfile() {
    // Implement navigation logic here
  }

  void goToLanguageScreen() {
    Get.to(() => const LanguageScreen());
  }

  void reviewApp() {
    // Implement review app logic here
  }

Future<void> logOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut();
      print("User Loged out");
      Get.offAll(() => SignInSignUpScreen());
    } catch (e) {
      print("Error logging out: $e");
    }
  }

}
