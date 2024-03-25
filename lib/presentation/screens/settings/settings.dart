import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/application/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/login_check.dart';
import 'package:code_geeks/presentation/screens/feedback/feedback.dart';
import 'package:code_geeks/presentation/screens/join_mentor/mentor_join.dart';
import 'package:code_geeks/presentation/screens/my_subscriptions/my_subs.dart';
import 'package:code_geeks/presentation/screens/settings/profile.dart';
import 'package:code_geeks/presentation/screens/settings/widgets/button.dart';
import 'package:code_geeks/presentation/screens/settings/widgets/profile_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;    
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight/8,
        // backgroundColor:  Color.fromARGB(69, 110, 132, 214),
         title:  Text("Settings",style: GoogleFonts.orbitron(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.grey)),
        actions: [const ModeButton(),const SizedBox(width: 5,), IconButton(onPressed: (){showLogOutDialog(context);}, icon: const Icon(Icons.logout))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              // SizedBox(height: 30,),
              // Text("Settings",style: GoogleFonts.orbitron(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.grey)),
              // const SizedBox(height: 30,),
               Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),)),
                  child: ProfileCard()),
              ),const SizedBox(height: 20,),
              //  ListTile(
              //   leading: const Icon(Icons.person_outline),
              //   title: const Text("Profile"),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),)),
              // ),
              ListTile(
                leading: const Icon(Icons.subscriptions_outlined),
                title: const Text("My Subscriptions"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MySubscriptionsPage(),)),
              ),
              //  ListTile(
              //   leading: const Icon(Icons.light_mode_outlined),
              //   title: const Text("Light/Dark Mode"),
              //   onTap: () {
              //     AdaptiveTheme.of(context).toggleThemeMode();
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.person_2_outlined),
                title: const Text("Become a mentor"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MentorJoinPage(),)),
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text("Feedback"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(),)),
              ),
               ListTile(
                leading: Icon(Icons.description_outlined),
                title: Text("Terms & Conditions"),
                onTap: () => _launchTCURL('https://www.freeprivacypolicy.com/live/c8a821ed-f744-4cfa-9ac4-ae3ff1359c08'),
              ),
               ListTile(
                leading: Icon(Icons.security_outlined),
                title: Text("Privacy Policy"),
                onTap: () => _launchPPURL('https://www.freeprivacypolicy.com/live/a5b1f3bb-5e9e-413f-8a11-cdc2e099c214'),
              ),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About us"),
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackPage(),)),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
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

  //to launch url
void _launchPPURL(String url) async{

           Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/a5b1f3bb-5e9e-413f-8a11-cdc2e099c214');
       if (await launchUrl(url)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch the page"));
      }
    } 

void _launchTCURL(String url) async{

           Uri url = Uri.parse('https://www.freeprivacypolicy.com/live/c8a821ed-f744-4cfa-9ac4-ae3ff1359c08');
       if (await launchUrl(url)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch the page"));
      }
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
    onPressed:  () async{
     await FirebaseAuth.instance.signOut();
      // FirebaseAuth.instance.s/
     //  FirebaseFirestore.instance.clearPersistence();
      // context.read<BnbBloc>().add(TabChangeEvent(tabIndex: 0));
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

