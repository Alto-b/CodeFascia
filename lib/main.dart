import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:code_geeks/domain/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/domain/login_check.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
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
    return BlocProvider(
      create: (context) => BnbBloc(),

      child: AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => 
      MaterialApp(
        title: 'Code Geeks',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,

        home: LoginCheckPage(),
      ),)
    );
  }
}
