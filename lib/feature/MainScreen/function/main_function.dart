

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pallon_app/main.dart';
import 'package:pallon_app/models/user_model.dart';

FirebaseMessaging fcm = FirebaseMessaging.instance;
Future<UserModel> GetUserData(String doc)async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  UserModel userModel=UserModel(doc: doc, email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  await for(var snap in firestore.collection('user').where('doc',isEqualTo: doc).snapshots()){
    userModel=UserModel(
        doc: doc, email: snap.docs[0].get('email'),
        phone: snap.docs[0].get('phone').toString(), name: snap.docs[0].get('name'),
        pic: snap.docs[0].get('pic'), type: snap.docs[0].get('type'));
    return userModel;
  }
  return userModel;
}

void getPermesion()async{
  NotificationSettings settings =  await fcm.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if(settings.authorizationStatus==AuthorizationStatus.authorized){
    print("User Granted Permesion");
  }
  else if(settings.authorizationStatus==AuthorizationStatus.provisional){
    print("User Granted Provisional ");
  }
  else{
    print("User Declind");
  }
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

    print('A new onMessageOpenedApp event was published!');
    print('Message data: ${message.data}');

    if (message.notification != null && message.notification!.title != null && message.notification!.body != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null && message.notification!.title != null && message.notification!.body != null) {
      print('Message also contained a notification: ${message.notification}');
      showNotification(message.notification!.title!, message.notification!.body!);
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message opened app from background: ${message.data}');
    // Navigate to a specific screen based on message.data
  });

}
Future<void> showNotification(String title, String body) async {
  var androidDetails = AndroidNotificationDetails(
      'channelId', 'channelName',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var platformDetails =
  NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
      0, title, body, platformDetails,
      payload: 'item x');
}