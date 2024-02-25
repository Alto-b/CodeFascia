import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/application/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/domain/login_check.dart';
import 'package:code_geeks/presentation/screens/feedback/feedback.dart';
import 'package:code_geeks/presentation/screens/settings/profile.dart';
import 'package:code_geeks/presentation/screens/settings/widgets/button.dart';
import 'package:code_geeks/presentation/screens/settings/widgets/profile_card.dart';
import 'package:code_geeks/presentation/screens/signup/profile_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [ModeButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text("Settings",style: GoogleFonts.orbitron(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.grey)),
              const SizedBox(height: 30,),
              Center(
                child: ProfileCard(),
              ),const SizedBox(height: 20,),
               ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),)),
              ),
               ListTile(
                leading: Icon(Icons.light_mode_outlined),
                title: Text("Light/Dark Mode"),
                onTap: () {
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
              ),
              ListTile(
                leading: Icon(Icons.person_2_outlined),
                title: Text("Profile setup"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupPage(),)),
              ),
              ListTile(
                leading: Icon(Icons.feedback_outlined),
                title: Text("Feedback"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(),)),
              ),
              ListTile(
                leading: Icon(Icons.description_outlined),
                title: Text("Terms & Conditions"),
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(),)),
              ),
              ListTile(
                leading: Icon(Icons.security_outlined),
                title: Text("Privacy Policy"),
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(),)),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About us"),
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(),)),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () {
                 showLogOutDialog(context);
                } 
              ),  
            ],
          ),
        ),
      ),
    );
  }
  showLogOutDialog(BuildContext context) {
  //cancel/continue button
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed:  () {
      FirebaseAuth.instance.signOut();
      // FirebaseAuth.instance.s/
      // FirebaseFirestore.instance.clearPersistence();
      context.read<BnbBloc>().add(TabChangeEvent(tabIndex: 0));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const EntryPage(),), (route) => false);
    },
  );
  //AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Warning!"),
    content: const Text("Would you like to logout ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}

