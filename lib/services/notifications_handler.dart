import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationHandler {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> initialize() async {
  //   await requestNotificationPermission();
  // }

  // // Request permission for receiving notifications
  // Future<void> requestNotificationPermission() async {
  //   NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  // Future<String?> getFCMToken() async {
  //   // Get the device token
  //   String? token = await _firebaseMessaging.getToken();
  //   return token;
  // }

  // void configureCallbacks() {
  //   // Configure callbacks for background/terminated state messages
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('User tapped on notification: ${message.notification}');
  //   });
  // }

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print('Handling a background message: ${message.notification}');
  // }

  // sendMessageNotifications(title, message) async {
  //   var headersList = {
  //     'Accept': '*/*',
  //     'Content-Type': 'application/json',
  //     'Authorization':
  //         'key=AAAAn0k0O98:APA91bF-dNRoieLrTrOPSMSP-J4tKcqhqO4ZYEPH-TVue0V730Yo9JUBAXRyHdfdnhhAubEcQ9w6ffZlVv48wcfRLpS-xaQlpN0Q5_SpbETefTgA1m6VzZ4PubfJcaQ1y7MCtqr1oqtQ'
  //   };
  //   var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  //   var body = {
  //     "to":
  //         "feHLq0DfQHSGP3v8JskX-Q:APA91bFFUHgSGDRJIUarIOx_5Se8eRJkEiwWt4qD1SzclkskhRcyfhwF4vrb3pSYU0YUfiPjvp9ISB0w1Z4PBwDfjBsbjyWzos1EARwrE0vyQv4RNc7vX0FBzLIQmwe7T4UBwdKNi_NA",
  //     "notification": {"title": title, "body": message}
  //   };

  //   var req = http.Request('POST', url);
  //   req.headers.addAll(headersList);
  //   req.body = json.encode(body);

  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();

  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     print(resBody);
  //   } else {
  //     print(res.reasonPhrase);
  //   }
  // }
}
// server key = AAAAn0k0O98:APA91bF-dNRoieLrTrOPSMSP-J4tKcqhqO4ZYEPH-TVue0V730Yo9JUBAXRyHdfdnhhAubEcQ9w6ffZlVv48wcfRLpS-xaQlpN0Q5_SpbETefTgA1m6VzZ4PubfJcaQ1y7MCtqr1oqtQ