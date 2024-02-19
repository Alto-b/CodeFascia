import 'package:code_geeks/domain/login_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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