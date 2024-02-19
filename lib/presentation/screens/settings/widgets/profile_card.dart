import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 110, 132, 214),
      ),
      child: GlassContainer(
        color: Colors.white.withOpacity(0.5),
        borderColor: Colors.white,
        height: 150,width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/animation/2022/12/01/17/03/17-03-11-60_512.gif', 
                  ),
                ),const SizedBox(height: 10,),
                Text(user!.email!,style: GoogleFonts.taiHeritagePro(fontWeight: FontWeight.w600,fontSize: 18),),                       
              ],
            ),
          ),
        ),
      ),
    );
  }
}