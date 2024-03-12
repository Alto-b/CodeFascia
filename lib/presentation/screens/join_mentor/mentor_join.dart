import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MentorJoinPage extends StatelessWidget {
   MentorJoinPage({super.key});

  final _key = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _name.text = FirebaseAuth.instance.currentUser!.displayName!;
    _email.text = FirebaseAuth.instance.currentUser!.email!;
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text("Join Us",style: GoogleFonts.orbitron(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Form(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: Text("Full name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),SizedBox(height: 20,),
                        TextFormField(
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: Text("Email id"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),SizedBox(height: 20,),
                        TextFormField(
                          controller: _contact,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: Text("Contact"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),SizedBox(height: 20,),
                        TextFormField(
                          controller: _about,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 10,
                          decoration: InputDecoration(
                            label: Text("About"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){}, child: Text("Submit",style: TextStyle(
                          color: Colors.white
                        ),),style: ButtonStyle(
                          backgroundColor:MaterialStatePropertyAll(Colors.green[400])
                        ),),
                        SizedBox(height: 20,),
                      ],
                      ),
                    )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}