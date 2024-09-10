import 'package:alert_brains/app/data/cache_helper.dart';
import 'package:alert_brains/app/modules/auth/data/models/game_details_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/games_level_model.dart';
import 'package:alert_brains/app/modules/auth/data/models/user_model.dart';
import 'package:alert_brains/app/modules/main_menu_screen/views/main_menu_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSigningIn = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        isSigningIn.value = true;

        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with credential
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Once signed in, save user data to Firestore
        await saveUserDataToFirestore(userCredential.user!);

        // final box = GetStorage(); // Get the instance of GetStorage
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          // Store user ID in GetStorage
          // box.write('uidToken', currentUser.uid);

          // Navigate to main menu screen
          Get.off(() => MainMenuScreen());
        }
      }
    } catch (error) {
      // Handle sign-in errors
      print("Error signing in with Google: $error");
    } finally {
      isSigningIn.value = false;
    }
  }

  Future<void> saveUserDataToFirestore(User user) async {
    try {
      UserModel userModel = UserModel(
        uId: user.uid,
        email: user.email!,
        name: user.displayName!,
        photoUrl: user.photoURL!,
        coins: 0,
        gamesLevelModel: GamesLevelModel(
          quickMath: GameDetailsModel(
            level: 0,
            trials: 3,
          ),
          memoPower: GameDetailsModel(
            level: 0,
            trials: 3,
          ),
          focus: GameDetailsModel(
            level: 0,
            trials: 3,
          ),
          speedyNumbers: GameDetailsModel(
            level: 0,
            trials: 3,
          ),
        ),
      );

      final firestore = FirebaseFirestore.instance;
      final userDocRef = firestore.collection('Users').doc(user.uid);

      // Check if user document already exists
      final userSnapshot = await userDocRef.get();
      if (!userSnapshot.exists) {
        // If user document doesn't exist, create it with user data
        await userDocRef.set(userModel.toMap());
        await CacheHelper.setUser(userModel.toMap());
      } else {
        print(userSnapshot.data());
        if (await CacheHelper.getUser() == null) {
          await CacheHelper.setUser(
              userSnapshot.data()!.cast<dynamic, dynamic>());
        }
      }
    } catch (error) {
      print("Error saving user data to Firestore: $error");
    }
  }
}
