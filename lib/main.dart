import 'dart:io';

import 'package:code_geeks/domain/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/domain/login_check.dart';
import 'package:code_geeks/presentation/screens/bnb.dart';
import 'package:code_geeks/presentation/screens/loading/onboarding_screen.dart';
import 'package:code_geeks/presentation/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: BlocProvider<BnbBloc>(
        create: (context) => BnbBloc(),
        child: const LoginCheckPage(),
      )
    );
  }
}
