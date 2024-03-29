import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        titleTextStyle:GoogleFonts.orbitron(fontSize: 15,fontWeight: FontWeight.w600,letterSpacing: 3,color: Colors.grey),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset('lib/assets/logo.png'),

            Text("At CodeFascia, we're passionate about fostering a vibrant and supportive community for individuals who are new to the field of software development and programming. Whether you're just starting your journey or looking to enhance your skills, we're here to provide you with the resources, guidance, and mentorship you need to succeed.",textAlign: TextAlign.justify,style: textStyle(),),
            const SizedBox(height: 30,),
            Text("- Empowering Developers, Building Futures -",textAlign: TextAlign.center,style: textStyle().copyWith(
              fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey
            ),),
            const Spacer(),
            Text("v.0.0.1",style: GoogleFonts.orbitron(
              fontWeight: FontWeight.w600,color: Colors.grey
            ),)        
          ],
        ),
      ),
    );
  }

  TextStyle textStyle() => GoogleFonts.poppins(
    fontSize: 17,
  );
}