// ignore_for_file: use_build_context_synchronously

import 'package:code_geeks/presentation/screens/signup/profile_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:passwordfield/passwordfield.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     body: SingleChildScrollView(
       child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
              Card(
                color: Colors.white,
                child: SizedBox(
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
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        // color: Colors.transparent,
                        child: TextFormField(
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            // hintText: "email id",
                            label: Text("Email"),
                            border: OutlineInputBorder(
                              
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Card(
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
                      const SizedBox(height: 10,),
                      Card(
                        child: PasswordField(
                          controller: _cpasswordController,
                          color: Colors.blue,
                          passwordConstraint: r'^(?=.*[@$#.*])(?=.*[0-9])[A-Za-z\d@$#.*]{6,}$',
                          hintText: 'Confirm Password',
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
                      const SizedBox(height: 40,),
                    SizedBox(
                width: double.infinity,
                child: LoadingBtn(
                    height: 40,
                    borderRadius: 8,
                    animate: true,
                    color: const Color.fromARGB(255, 110, 132, 214),
                    width: MediaQuery.of(context).size.width * 0.45,
                    loader: Container(
                        padding: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                    ),
                    child: const Text("SignUp",style: TextStyle(color: Colors.white),),
                    onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.idle) {
                            startLoading();
                            if(_formKey.currentState!.validate()){
                                          signUp(context);
                                          }
                            await Future.delayed(const Duration(seconds: 2));
                            stopLoading();
                        }
                    },
                ),
              ),
                        const SizedBox(height: 10,),
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
    if(_passwordController.text.trim()==_cpasswordController.text.trim() && _formKey.currentState!.validate()){
       try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text);
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfileSetupPage(),), (route) => false);
   }
    on FirebaseAuthException catch(e){ 
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${e.message}"),backgroundColor: Colors.red)); 
    debugPrint(e.message);
   }
    }
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