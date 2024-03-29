
// ignore_for_file: use_build_context_synchronously
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CodeFascia/presentation/widgets/bnb.dart';
import 'package:CodeFascia/presentation/screens/loading/onboarding_screen.dart';
import 'package:CodeFascia/presentation/screens/login/login.dart';
import 'package:CodeFascia/presentation/screens/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';


// ignore: unused_element
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes:['email'] );

class LoginCheckPage extends StatelessWidget {
  const LoginCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return const Center(child: Text("Something not right"));
          }
          else if(snapshot.hasData){
            return BnbPage();
          }
          else{
            return const OnBoardingPage();
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
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          AdaptiveTheme.of(context).toggleThemeMode();
        }, icon: const Icon(Icons.light_mode_outlined))],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //logo
              Container(
                height: screenHeight-(screenHeight/1.5),
                width: screenWidth-80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/logo.png'),
                    fit: BoxFit.cover)
                ),
              ),
        
              //hola
              Text("Hola !",style: GoogleFonts.orbit(
                fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black54
              ),),
        
              const SizedBox(height: 40,),
        
              //login button
              SizedBox(
                width: screenWidth-100,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  },
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 110, 132, 214))
                  ), 
                  child: const Text("Login"),
                  )),
                  const SizedBox(height: 20,),
        
                  //signup button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color:(const Color.fromARGB(255, 110, 132, 214)),
                      )
                    ),
                width: screenWidth-100,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                  },
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 110, 132, 214)),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ), 
                  child: const Text("Signup"),
                  )),
                //divider
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                  child: Divider(thickness: 2,),
                ),

                //continue with
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _signInWithGoogle(context);
                      },
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/989/129/png-transparent-google-logo-google-search-meng-meng-company-text-logo-thumbnail.png'),),
                    ),
                  ],
                ) 
            ],
          ),
        ),
      ),
    );
  }
  Future _signInWithGoogle(BuildContext context)async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount !=  null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
        );
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
          "uid": user.uid,
          "Name": user.displayName,
          "Email": user.email,
          "profile": user.photoURL
        });
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BnbPage(),), (route) => false);
      }
    }
    catch(e){
        debugPrint("exception is : $e");
    }
  }

// Future<UserCredential> signInWithFacebook() async {
//   final LoginResult loginResult = await FacebookAuth.instance.login();
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
}