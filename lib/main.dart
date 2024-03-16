import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:code_geeks/application/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/application/feedback_bloc/feedback_bloc.dart';
import 'package:code_geeks/application/gemini_bloc/gemini_bloc.dart';
import 'package:code_geeks/application/history_bloc/history_bloc.dart';
import 'package:code_geeks/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:code_geeks/application/image_picker_utils.dart';
import 'package:code_geeks/application/join_mentor/join_mentor_bloc.dart';
import 'package:code_geeks/application/post_bloc/post_bloc.dart';
import 'package:code_geeks/application/sign%20up%20bloc/image_update_bloc/image_bloc.dart';
import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/application/user_bloc/user_bloc.dart';
import 'package:code_geeks/domain/login_check.dart';
import 'package:code_geeks/infrastructure/language_repo.dart';
import 'package:code_geeks/infrastructure/mentor_repo.dart';
import 'package:code_geeks/infrastructure/post_repo.dart';
import 'package:code_geeks/infrastructure/subscription_repo.dart';
import 'package:code_geeks/infrastructure/user_repo.dart';
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
          apiKey: "AIzaSyDFLURsPEzl6KV3Aau3POzWV3JUJd9plz0", 
          projectId: "code-geeks-ff98c", 
          messagingSenderId: "688360665265", 
          appId: "1:688360665265:android:a76df499c29b711251f290",
          storageBucket: 'code-geeks-ff98c.appspot.com', 
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
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeBloc(LanguageRepo(),MentorRepo()),
            ),
            BlocProvider(
              create: (context) => FeedbackBloc(),
            ),
              BlocProvider(
              create: (context) => ImageBloc(),
      
            ),
              BlocProvider(
                  create: (context) => ImagePickerBloc(ImagePickerUtils()),
              ),
               BlocProvider(
                  create: (context) => GeminiBloc(),
              ),
              BlocProvider(
                  create: (context) => UserBloc(UserRepo()),
              ),
              BlocProvider(
                  create: (context) => JoinMentorBloc(),
              ),
              BlocProvider(
                  create: (context) => SubscriptionBloc(SubscriptionRepo(),UserRepo()),
              ),
              BlocProvider(
                  create: (context) => PostBloc(PostRepo()),
              ),
              BlocProvider(
                  create: (context) => HistoryBloc(SubscriptionRepo()),
              ),
          ],
                  child: MaterialApp(
                    title: 'Code Geeks',
                    debugShowCheckedModeBanner: false,
                    theme: theme,
                    darkTheme: darkTheme,
                    
            
                    home: LoginCheckPage(),
                  ),
      ),)
    );
  }
}
