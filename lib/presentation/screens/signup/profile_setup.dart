// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CodeFascia/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:CodeFascia/presentation/widgets/bnb.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;


class ProfileSetupPage extends StatelessWidget {
  // final _bloc = ImagePickerBloc();
   ProfileSetupPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final List<String> skillItems = [
    'Student','Working IT','Working Non IT'
  ];

  String? selectedSkill;

  XFile? newImge;

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
              const SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                children: [
                  BlocBuilder<ImagePickerBloc,ImagePickerState>(
                    builder: (context,state){
                      if(state.file==null){
                        return InkWell(
                          onTap: () {
                            context.read<ImagePickerBloc>().add(GalleryPicker());
                            newImge = state.file;
                            
                          },
                          child: const CircleAvatar(child:  Icon(Icons.add_a_photo),),
                        );
                      }
                      else{
                        return GestureDetector(
                                onTap: () {
                                  context.read<ImagePickerBloc>().add(GalleryPicker());
                                  newImge = state.file;
                                },
                                child: CircleAvatar(
                                     radius: 60,
                                 // child: Image.file(File(state.file!.path.toString()))
                                  backgroundImage: FileImage(File(state.file!.path.toString()))
                                ),
                              );
                      }
                    }),
                  const SizedBox(height: 30,),
        
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Name")
                    ),
                  ),
        
                  const SizedBox(height: 30,),

                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email")
                    ),
                  ),
        
                  const SizedBox(height: 30,),
        
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      )
                    ),
                    hint: const Text("Select your profession"),
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
                    const SizedBox(height: 30,),
                  
        
                    BlocBuilder<ImagePickerBloc, ImagePickerState>(
                      builder: (context, state) {
                        return ActionChip.elevated(label: const Text("Proceed"),onPressed: () {
                                          // profileSetup(context,selectedImage);
                                          profileSetup(context,state.file!.path.toString());
                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Creating profile !"),backgroundColor: Colors.blue,duration: Duration(seconds: 5),));
                                        },);
                      },
                    )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  } 

Future<void> profileSetup(BuildContext context, String newImg) async {
  File file = File(newImg);

  if (!file.existsSync()) {
    return;
  }

  // String fileName = basename(newImg);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("profilepic${FirebaseAuth.instance.currentUser!.uid}");
  firebasestorage.UploadTask uploadTask = ref.putFile(file);

  try {
    await uploadTask;
    var downloadUrl = await ref.getDownloadURL();

     Map<String, String> data = {
    "id": FirebaseAuth.instance.currentUser!.uid,
    "Name": _nameController.text,
    "Profession": selectedSkill!,
    "Email": _emailController.text,
    "profile": downloadUrl 
  };

    //trying to fix the user data accuracy issue 
    await FirebaseAuth.instance.currentUser!.updateDisplayName(_nameController.text.trim());
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);

    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(data)
      .then((_) {  
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Profile Created !"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BnbPage()),
      (route) => false,
    );
      });
  }
  on FirebaseAuthException catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${error.message}"),backgroundColor: Colors.red,duration: const Duration(seconds: 2),));

  }
}
}
