import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_geeks/domain/login_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.uid),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EntryPage(),), (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,width: 500,
              color: Colors.blue,
              child: Icon(Icons.abc,size: 50,),
            ),
            CarouselSlider(
                options: CarouselOptions(
                  height: 200, 
                  enlargeCenterPage: true, 
                  aspectRatio: 16/9, 
                  //aspectRatio: 4/3,
                  enableInfiniteScroll: true,
                  autoPlay: true, 
                  autoPlayInterval: Duration(seconds: 3), 
                  autoPlayAnimationDuration: Duration(milliseconds: 1000), 
                  autoPlayCurve: Curves.fastOutSlowIn, 
                  //autoPlayCurve: Curves.easeIn,
                  enlargeStrategy: CenterPageEnlargeStrategy.height, 
                ),
                items: [
                  // Add your carousel items here, e.g., Container, Image, or any widget
                  Container(
                    //color: Colors.red,
                    child: Center(child: Image.asset('lib/assets/logo.png')),
                  ),
                  Container(
                    //color: Colors.blue,
                    child: Center(child: Image.asset('lib/assets/logo.png')),
                  ),
                  Container(
                    //color: Colors.green,
                    child: Center(child: Image.asset('lib/assets/logo.png')),
                  ),
                ],
              ),
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Image.asset('lib/assets/logo.png',
      //   fit: BoxFit.cover,
      //   ),
      //   tooltip: "AI Chat",
      //   splashColor: Colors.grey,
      //   shape: CircleBorder(),
      //   backgroundColor: Color.fromARGB(255, 110, 132, 214),)
    );
  }
}