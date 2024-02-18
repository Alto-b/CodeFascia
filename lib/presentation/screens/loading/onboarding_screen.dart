
import 'package:code_geeks/domain/login_check.dart';
import 'package:code_geeks/presentation/screens/loading/intro_page1.dart';
import 'package:code_geeks/presentation/screens/loading/intro_page2.dart';
import 'package:code_geeks/presentation/screens/loading/intro_page3.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
   const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          //page view
          PageView(
            controller: _controller,
            onPageChanged:(index){
              setState(() {
                  onLastPage = (index==2);
              }
              );
            } ,
        children: const [
          IntroPage1(),
          IntroPage2(),
          IntroPage3()
        ],
      ),

      //dot indicator
      Container(
        alignment: const Alignment(0, 0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //skip 
            GestureDetector(
              onTap: (){
                _controller.jumpToPage(2);
              },
              child: const Text("Skip",style: TextStyle(color:Colors.white),)
              ),

            //dots
            SmoothPageIndicator(controller: _controller, count: 3),

            //next/done
            onLastPage?
             GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EntryPage(),),(route) => false,);
              },
              child: const Text("Proceed",style: TextStyle(color:Colors.white),)
              )
              :
              GestureDetector(
              onTap: (){
                _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              child: const Text("Next",style: TextStyle(color:Colors.white),)
              )
             
          ],
        )),
        ],
      )
    );
  }
}