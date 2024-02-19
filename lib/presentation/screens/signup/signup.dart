import 'package:code_geeks/presentation/screens/signup/profile_setup.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     body: SingleChildScrollView(
       child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
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
              Text("Create An Account",style: GoogleFonts.orbit(
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
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: _cpasswordController,
                        decoration: const InputDecoration(
                          hintText: "Confirm Password",
                          // label: Text("password"),
                          border: OutlineInputBorder(
                            
                          )
                        ),
                      ),
                      const SizedBox(height: 40,),
       
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){
                          signUp(context);
                        }, child: const Text("Sign up"),style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 110, 132, 214))
                        ),)),
       
                        const SizedBox(height: 10,),
       
                        // TextButton.icon(onPressed: (){}, icon: Icon(Icons.arrow_back_ios), label: Text("")),
                        // IconButton.outlined(onPressed: (){}, icon: Icon(Icons.arrow_back)),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon:  const Icon(Icons.arrow_back))
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

  Future signUp(BuildContext context)async{
    if(_passwordController.text.trim()==_cpasswordController.text.trim()){
       try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text);



      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfileSetupPage(),), (route) => false);
   }
   catch(e){  
    print(e);
   }
    }
  }

  
}