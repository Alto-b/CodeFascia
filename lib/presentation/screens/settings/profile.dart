import 'package:code_geeks/presentation/screens/settings/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(

      appBar: AppBar(
        title: Text("My profile",style: GoogleFonts.orbitron(fontSize: 15),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            ProfileCard(user: user)
          ],
        ),
      
      ),
    );
  }
}