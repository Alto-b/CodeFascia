import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwordfield/passwordfield.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        // color: Colors.white70,
                        child: TextFormField(     
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      // Card(
                      //   color: Colors.transparent,
                      //   child: TextFormField(
                      //     // validator: validatePassword,
                      //     controller: _passwordController,
                      //     decoration: const InputDecoration(
                      //       // hintText: "email id",
                      //       label: Text("Password"),
                      //       border: OutlineInputBorder(
                              
                      //       )
                      //     ),
                      //   ),
                      // ),
                      Card(
                        // color: Colors.black12,
                        child: PasswordField(
                          controller: _passwordController,
                          color: Colors.blue,
                          passwordConstraint: r'^(?=.*[@$#.*])(?=.*[0-9])[A-Za-z\d@$#.*]{6,}$',
                          hintText: 'Password',
                          border: PasswordBorder(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue.shade100,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue.shade100,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.red.shade200),
                            ),
                          ),
                          errorMessage:
                              'must include special character & 6 characters',
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){forgotPassword(_emailController.text);}, child: Text("Forgot password?",style: TextStyle(fontSize: 12),),)),
                      const SizedBox(height: 30,),
        
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){
                          if(_formKey.currentState!.validate()){
                        
                          signIn(context);
                          }
                          
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Welcome aboard !"),backgroundColor: Colors.green,duration: Duration(seconds: 1),));
      await Future.delayed(Duration(seconds:2));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => BnbPage() ), (route) => false);
   }
   on FirebaseAuthException catch(e){  
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${e.message}"),backgroundColor: Colors.red));
    // _scaffoldKey.currentState?.showSnackBar(SnackBar(
    //     content: Text(e.toString()),
    //   ));
    print(e);
   }
  }

  forgotPassword(String email)async{

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
   }

     
     //to validate email
String? validateEmail(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; 
}

//to validate password
String? validatePassword(String? value) {
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Password cannot be empty';
  }

  final passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+])[a-zA-Z\d!@#\$%^&*()_+]{8,}$',
  );

  if (!passwordRegExp.hasMatch(trimmedValue)) {
    return 'One alphabet, one number, and one special symbol';
  }

  return null;
}


}