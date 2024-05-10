import 'dart:io';

import 'package:CodeFascia/options.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:CodeFascia/application/bnb_bloc/bnb_bloc.dart';
import 'package:CodeFascia/application/feedback_bloc/feedback_bloc.dart';
import 'package:CodeFascia/application/gemini_bloc/gemini_bloc.dart';
import 'package:CodeFascia/application/history_bloc/history_bloc.dart';
import 'package:CodeFascia/application/home_page_bloc/home_bloc.dart';
import 'package:CodeFascia/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:CodeFascia/application/image_picker_utils.dart';
import 'package:CodeFascia/application/join_mentor/join_mentor_bloc.dart';
import 'package:CodeFascia/application/post_bloc/post_bloc.dart';
import 'package:CodeFascia/application/sign%20up%20bloc/image_update_bloc/image_bloc.dart';
import 'package:CodeFascia/application/subscription_bloc/subscription_bloc.dart';
import 'package:CodeFascia/application/user_bloc/user_bloc.dart';
import 'package:CodeFascia/login_check.dart';
import 'package:CodeFascia/infrastructure/language_repo.dart';
import 'package:CodeFascia/infrastructure/mentor_repo.dart';
import 'package:CodeFascia/infrastructure/post_repo.dart';
import 'package:CodeFascia/infrastructure/subscription_repo.dart';
import 'package:CodeFascia/infrastructure/user_repo.dart';
import 'package:CodeFascia/presentation/screens/error_pages/no_internet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// bool internetResult=false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool internetResult = await InternetConnectionChecker().hasConnection;

  Platform.isAndroid
      ? await Firebase.initializeApp(options: FirebaseConfig.options)
      : await Firebase.initializeApp();

//  await FirebaseApi().initNotifications();

//  final fcmToken = await FirebaseMessaging.instance.getToken();
//   await FirebaseMessaging.instance.setAutoInitEnabled(true);
//   print("FCMToken $fcmToken");

  runApp(MyApp(
    internetResult: internetResult,
  ));
}

class MyApp extends StatelessWidget {
  final bool internetResult;
  const MyApp({super.key, required this.internetResult});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BnbBloc(),
        child: AdaptiveTheme(
          light: ThemeData.light(useMaterial3: true),
          dark: ThemeData.dark(useMaterial3: true),
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeBloc(LanguageRepo(), MentorRepo()),
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
                create: (context) =>
                    SubscriptionBloc(SubscriptionRepo(), UserRepo()),
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
              home: internetResult
                  ? const LoginCheckPage()
                  : const NoInternetPage(),
            ),
          ),
        ));
  }
}
