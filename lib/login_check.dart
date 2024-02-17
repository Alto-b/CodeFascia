import 'package:code_geeks/presentation/pages/homepage/homepage.dart';
import 'package:code_geeks/presentation/pages/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginCheckPage extends StatelessWidget {
  const LoginCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text("something not right"));
          }
          else if(snapshot.hasData){
            return HomePage();
          }
          else{
            return EntryPage();
          } 
        },
      ),
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: Column(
          children: [
            //logo
            Container(
              height: screenHeight-(screenHeight/1.5),
              width: screenWidth-80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/logo.png'),
                  fit: BoxFit.cover)
              ),
            ),

            //hola
            Text("Hola !",style: GoogleFonts.orbit(
              fontSize: 20,fontWeight: FontWeight.w700
            ),),

            SizedBox(height: 40,),

            //login button
            Container(
              width: screenWidth-100,
              height: 50,
              child: ElevatedButton(
                onPressed: (){},
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 110, 132, 214))
                ), 
                child: Text("Login"),
                )),
                SizedBox(height: 20,),

                //signup button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color:(Color.fromARGB(255, 110, 132, 214)),
                    )
                  ),
              width: screenWidth-100,
              height: 50,
              child: ElevatedButton(
                onPressed: (){},
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 110, 132, 214)),
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ), 
                child: const Text("Signup"),
                )),

              // SizedBox(height: 20,),

              //divider
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Divider(thickness: 2,),
              ),

              //continue with
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/989/129/png-transparent-google-logo-google-search-meng-meng-company-text-logo-thumbnail.png'),),
                    SizedBox(width: 10,),
                  CircleAvatar(backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/646/324/png-transparent-github-computer-icons-github-logo-monochrome-head.png'),),
                ],
              ),

              
              
          ],
        ),
      ),
    );
  }
}