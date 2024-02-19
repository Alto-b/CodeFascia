import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupPage extends StatelessWidget {
   ProfileSetupPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final List<String> skillItems = [
    'Student','Working IT','Working Non IT'
  ];

  String? selectedSkill;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Set up your profile",style: GoogleFonts.orbit(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.grey),),
            SizedBox(height: 30,),
            Form(
              key: _formKey,
              child: Column(
              children: [

                CircleAvatar(
                  radius: 60,
                ),

                SizedBox(height: 30,),

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name")
                  ),
                ),

                SizedBox(height: 30,),

                DropdownButtonFormField2<String>(
                  validator: (value) {
                    if(value == null){
                      return 'Please enter your profession';
                    }
                    else{
                      return null;
                    }
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    )
                  ),
                  hint: Text("Select your profession"),
                  items: skillItems.map((item) => 
                  DropdownMenuItem(
                    value: item,
                    child: Text(item))).toList(),
                    onChanged: (value) {
                      selectedSkill = value.toString();
                    },
                    onSaved: (value) {
                      selectedSkill = value.toString();
                    },
                  ),

                  SizedBox(height: 30,),

                  ActionChip.elevated(label: Text("Proceed"),onPressed: () {
                    profileSetup(context);
                  },)




              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<void> profileSetup(BuildContext context)async{
    await FirebaseFirestore.instance.collection('users').doc().set({
      "Name" : _nameController.text,
      "Profession" : selectedSkill,
      "Email" : FirebaseAuth.instance.currentUser!.email
    });
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BnbPage(),), (route) => false);
  }
}