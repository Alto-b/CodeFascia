
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message)async {
//   // print('Title : ${message.notification?.title}');
//   // print('Body : ${message.notification?.body}');
//   // print('Payload : ${message.data}');
//   }

//   void handleMessage(RemoteMessage? message){
//     if(message==null)return;
    
//   }

// class FirebaseApi{
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initNotifications() async{
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     debugPrint('Token: $fCMToken');
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }

  
// }