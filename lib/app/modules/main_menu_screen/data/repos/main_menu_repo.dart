import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainMenuRepo {
  Future<Map> getCurrentUser() async {
    final firestore = FirebaseFirestore.instance;
    String uId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef = firestore.collection('Users').doc(uId);
    final userDocument = await userDocRef.get();

    return userDocument.data()!;
  }

  Future<void> updateCurrentUser(Map hiveUser) async {
    final firestore = FirebaseFirestore.instance;
    String uId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef = firestore.collection('Users').doc(uId);
    await userDocRef.update(hiveUser.cast<Object, Object?>());
  }
}
