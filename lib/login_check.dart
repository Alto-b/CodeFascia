
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/presentation/screens/signup/profile_setup.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:code_geeks/presentation/screens/loading/onboarding_screen.dart';
import 'package:code_geeks/presentation/screens/login/login.dart';
import 'package:code_geeks/presentation/screens/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:github_sign_in/github_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
        }, icon: Icon(Icons.light_mode_outlined))],
      ),

      body: SingleChildScrollView(
        child: Center(
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
                fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black54
              ),),
        
              SizedBox(height: 40,),
        
              //login button
              Container(
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
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                  },
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
                    //   const SizedBox(width: 10,),
                    // GestureDetector(
                    //   onTap: () {
                    //     signInWithFacebook();
                    //   },
                    //   child: const CircleAvatar(backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/646/324/png-transparent-github-computer-icons-github-logo-monochrome-head.png'),)
                    //   ),
                  ],
                ) 
            ],
          ),
        ),
      ),
    );
  }
  Future _signInWithGoogle(BuildContext context)async{
    // print("clicked");
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      // print("1");
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      // print("2");
      if(googleSignInAccount !=  null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      // print("3");
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
        );
        // print("4");
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
        print("exception is : $e");
    }
  }

//   Future<void> _signInWithGoogle(BuildContext context) async {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   try {
//     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken,
//       );

//       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//       User? user = userCredential.user;

//       // Check if the user email already exists in the "users" collection
//       var userDoc = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
//       if (userDoc.exists) {
//         // User already exists, navigate to home page
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => BnbPage()),
//           (route) => false,
//         );
//       } else {
//         // User doesn't exist, proceed to profile setup page
//         await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
//           "uid": user.uid,
//           "Name": user.displayName,
//           "Email": user.email,
//           "profile": user.photoURL,
//         });

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => ProfileSetupPage()),
//           (route) => false,
//         );
//       }
//     }
//   } catch (e) {
//     print("Error signing in: $e");
//     // Handle error here
//   }
// }


//   Future<UserCredential> signInWithGitHub() async {
  
// }

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}


}