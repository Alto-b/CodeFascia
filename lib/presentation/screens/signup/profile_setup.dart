import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileSetupPage extends StatelessWidget {
   ProfileSetupPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final List<String> skillItems = [
    'Student','Working IT','Working Non IT'
  ];

  String? selectedSkill;

  PlatformFile? selectedImage;
  bool imageAvailable = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    _emailController.text = user!.email!;
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Set up your profile",style: GoogleFonts.orbit(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.grey),),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                children: [
        
                  GestureDetector(
                    onTap: () async{
                      final result = await FilePicker.platform.pickFiles(type: FileType.image);
                      if(result==null)return;
                        selectedImage = result.files.first;
                    },
                    child: CircleAvatar(
                      radius: 60,
                      child: Container(
                        child: imageAvailable?Image.file(selectedImage as File):Icon(Icons.photo),
                      )
                    ),
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

                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email")
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
      ),
    );
  }

  Future<void> profileSetup(BuildContext context)async{



    Map<String,String> data ={
      "id" : FirebaseAuth.instance.currentUser!.uid,
      "Name" : _nameController.text,
      "Profession" : selectedSkill!,
      "Email" : _emailController.text
    };
    print("fire1");
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(data)
    .onError((error, _) => print("error is $error"));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BnbPage(),), (route) => false);
  }

  // Future _photoImage() async {
  //   // final picker = ImagePicker();
  //   // final pickedImage = await picker.pickImage(source: ImageSource.camera);

  //   // if (pickedImage != null) {
  //   //   // setState(() {
  //   //   //   _selectedImage = File(pickedImage.path);
  //   //   // });
  //   // }
  //   final result = await FilePicker.platform.pickFiles(type: FileType.image);
  //   if(result==null)return;
  //   final  pickedFile = result.files.first;
  // }
}