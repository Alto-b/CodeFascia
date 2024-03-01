import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_geeks/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/carousal.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/language_avatar.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/mentor_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // @override
  // void initState() {
  //   context.read<HomeBloc>().add(LanguageLoadEvent());
  //   context.read<HomeBloc>().add(MentorLoadEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

       body: SingleChildScrollView(
              child: Column(
                children: [
                  //carousal
                  HomeCarousal(),

                  SizedBox(height: 20,),

                  //languages
                  language_avatars(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),

                  SizedBox(height: 20,),
                  
                  //community card
                  Container(
                    height: screenHeight/6,
                    width: screenWidth-50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey
                      )
                    ),
                    child: Image.network('https://www.2020spaces.com/wp-content/uploads/2022/11/1280x720-Community_EN_Transparent-Draft04D.gif',
                    fit: BoxFit.contain,),
                  ),

                  SizedBox(height: 50,),

                  //mentors
                  MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
                  
                ],
              ),
            )
    );
  }
}
