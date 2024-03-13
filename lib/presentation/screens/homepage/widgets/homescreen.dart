import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_geeks/presentation/screens/community/community_chat.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/carousal.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/language_avatar.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/mentor_card_list.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),

  //     body: CustomScrollView(
  //   slivers: <Widget>[
  //     //2
  //      SliverAppBar(
  //       expandedHeight: 250.0,
  //       flexibleSpace: FlexibleSpaceBar(
  //         background:HomeCarousal()
  //       ),
  //       pinned: true,
  //       backgroundColor:  Color.fromARGB(143, 110, 132, 214),
  //       bottom: AppBar(
  //         title: Container(
  //           height: 45,
  //           child: TextField(
  //             decoration: InputDecoration(
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(30)
  //                 ),
  //                 hintText: 'Search some codes..'),
  //           ),
  //         ),
  //       ),
  //     ),
    
  //     // 3
  //     SliverList(
  //       delegate: SliverChildBuilderDelegate(
  //         (_, int index) {
  //           return Column(
  //               children: [
  //                 //carousal
  //                 // const HomeCarousal(),

                  
       
  //                 const SizedBox(height: 20,),
       
  //                 //languages
  //                 language_avatars(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
       
  //                 const SizedBox(height: 20,),
                  
  //                 //community card
  //                 Container(
  //                   height: screenHeight/6,
  //                   width: screenWidth-50,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(25),
  //                     border: Border.all(
  //                       width: 0.5,
  //                       color: Colors.grey
  //                     ),
  //                   ),
  //                   child: Image.network('https://www.2020spaces.com/wp-content/uploads/2022/11/1280x720-Community_EN_Transparent-Draft04D.gif',
  //                   filterQuality: FilterQuality.high,
  //                   fit: BoxFit.contain,),
  //                 ),
       
  //                 const SizedBox(height: 50,),
       
  //                 //mentors
  //                 MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
       
  //      MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
       
                  
  //               ],
  //             );

  //         },
  //         childCount: 1,
  //       ),
  //     ),
  //   ],
  // ),


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
                        placeholder: (context, url) => Text("Community"),
                        ),
                      ),
                    ),
                       
                    // const SizedBox(height: 50,),
                    
                    // Column(
                    //   children: [
                    //     Text("data"),
                    //     Container(
                    //       height: screenHeight/7,
                    //       width: screenWidth,
                    //       child: Column(
                    //         children: [
                    //           ListView.builder(
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: 3,
                    //             itemBuilder: (context, index) {
                    //             return Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: Container(
                    //                     height: screenHeight/9,
                    //                     width: screenWidth/3,
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //               ],
                    //             );
                    //           },),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 50,),
                       
                    //mentors
                    MentorCardHPWidget(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),
                       
                       
                    
                  ],
                ),
              ),
            )
    );
  }
}
