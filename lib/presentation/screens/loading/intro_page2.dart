
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 199, 62, 107),
 backgroundColor: Color.fromARGB(255, 110, 132, 214),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("A Tutor You Get Along With",style: GoogleFonts.cinzel(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w600
                ),),
              SizedBox(height: 20,),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('lib/assets/anim1.gif'),fit:BoxFit.cover)
                ),
                )
            ],
        ),
      ),
    );
  }
}