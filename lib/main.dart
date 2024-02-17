import 'dart:io';

import 'package:code_geeks/login_check.dart';
import 'package:code_geeks/presentation/pages/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp( 
      options: const FirebaseOptions( 
          apiKey: "AIzaSyBLZ1YwqrUYwK-ZMaPPMIKjLzVg0WLkwpc", 
          projectId: "1:420845583497:android:4ca387c2fad8f8941a5a58", 
          messagingSenderId: "420845583497", 
          appId: "code-geeks-78d47",
          storageBucket: 'code-geeks-78d47.appspot.com' 
        ) 
  ):
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginCheckPage()
    );
  }
}
