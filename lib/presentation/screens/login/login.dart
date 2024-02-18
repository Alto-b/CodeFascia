import 'package:code_geeks/presentation/screens/bnb.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Card(
                color: Colors.white,
                child: Container(
                  height: 150,
                  width: 150,
                  // color: Colors.green,
                  child: Image.asset('lib/assets/logo.png',fit: BoxFit.cover,height: 100,width: 100,),
                ),
              ),
              const SizedBox(height: 30,),
              //create an account
              Text("Login",style: GoogleFonts.orbit(
                fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black54
              ),),
              const SizedBox(height: 30,),
        
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          // hintText: "email id",
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            
                          )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          // hintText: "email id",
                          label: Text("Password"),
                          border: OutlineInputBorder(
                            
                          )
                        ),
                      ),
                      const SizedBox(height: 40,),
        
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){
                          signIn(context);
                        }, child: const Text("Login"),style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 110, 132, 214))
                        ),)),
        
                        const SizedBox(height: 10,),
        
                        // TextButton.icon(onPressed: (){}, icon: Icon(Icons.arrow_back_ios), label: Text("")),
                        // IconButton.outlined(onPressed: (){}, icon: Icon(Icons.arrow_back)),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon:  const Icon(Icons.arrow_back),)
                    ],
                  )
                  ),
              )
        
        
            ],
          ),
        ),
      ),
    );
  }
  Future signIn(BuildContext context) async{
   try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => HomePage() ), (route) => false);
   }
   catch(e){  
    print(e);
   }
  }
}