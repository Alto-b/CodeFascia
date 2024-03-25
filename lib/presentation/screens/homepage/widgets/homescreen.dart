import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/presentation/screens/community/community_chat.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/carousal.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/language_avatar.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/mentor_card_list.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/subs_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
       body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    //carousal
                    const HomeCarousal(),
                       
                    const SizedBox(height: 20,),
                       
                    //languages
                    language_avatars(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
                       
                    const SizedBox(height: 20,),
                    
                    //community card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityPage(),));
                      },
                      child: Container(
                        height: screenHeight/6,
                        width: screenWidth-50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey
                          ),
                        ),
                        // child: Image.network('https://www.2020spaces.com/wp-content/uploads/2022/11/1280x720-Community_EN_Transparent-Draft04D.gif',
                        // filterQuality: FilterQuality.high,
                        // fit: BoxFit.contain,),
                        child: CachedNetworkImage(imageUrl: 'https://www.2020spaces.com/wp-content/uploads/2022/11/1280x720-Community_EN_Transparent-Draft04D.gif',
                        fadeInCurve: Curves.bounceIn,
                        fadeInDuration: Duration(seconds: 1),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(child: Text("Community",style: GoogleFonts.orbitron(
                          fontSize: 25,fontWeight: FontWeight.w600,color: Colors.grey
                        ),)),
                        ),
                      ),
                    ),
                       
                    const SizedBox(height: 40,),
                    //ongoing subs
                    Card(
                      color: Colors.grey[200],
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("Active Subscriptions",style: GoogleFonts.poppins(
                            fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black54
                          ),),
                          SizedBox(height: 10,),
                          OngoingSubsSlider(),
                        ],
                      ),
                    )),

                    const SizedBox(height: 30,),
                       
                    //mentors
                    MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
                       
                       
                    
                  ],
                ),
              ),
            )
    );
  }
}
