import 'package:cached_network_image/cached_network_image.dart';
import 'package:CodeFascia/presentation/screens/community/community_chat.dart';
import 'package:CodeFascia/presentation/screens/homepage/widgets/carousal.dart';
import 'package:CodeFascia/presentation/screens/homepage/widgets/language_avatar.dart';
import 'package:CodeFascia/presentation/screens/homepage/widgets/mentor_card_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({super.key});

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
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: const HomeCarousal()),
                       
                    const SizedBox(height: 20,),
                       
                    //languages
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: language_avatars(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth)),
                       
                    const SizedBox(height: 20,),
                    
                    //community card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CommunityPage(),));
                      },
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
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
                          fadeInDuration: const Duration(seconds: 1),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(child: Text("Community",style: GoogleFonts.orbitron(
                            fontSize: 25,fontWeight: FontWeight.w600,color: Colors.grey
                          ),)),
                          ),
                        ),
                      ),
                    ),
                       
                    const SizedBox(height: 50,),
                       
                    //mentors
                    Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth)),
                       
                       
                    
                  ],
                ),
              ),
            )
    );
  }
}
