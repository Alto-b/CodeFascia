import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:code_geeks/presentation/widgets/loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;


class ProfileSetupPage extends StatelessWidget {
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
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Creating profile !"),backgroundColor: Colors.blue,duration: Duration(seconds: 3),));
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

  // void pickUploadImage()async{
  //   final result = await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 512,maxWidth: 512,imageQuality: 75);
  //   Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
  //   await ref.putFile(File(result!.path));
  //   ref.getDownloadURL().then((value){
  //     print("image link $value");
  //   });
  // }

  //  Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = basename(selectedImage!.path);
  //   Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
  //   await ref.putFile(File(fileName));
  //   ref.getDownloadURL().then((value){
  //     print("image link $value");
  //     return value;
  //   });
  // }

Future<void> profileSetup(BuildContext context, String newImg) async {
  print("selected image $newImg");
  File file = File(newImg);

  if (!file.existsSync()) {
    print("Error: File does not exist");
    return;
  }

  // String fileName = basename(newImg);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("profilepic${FirebaseAuth.instance.currentUser!.uid}");
  firebasestorage.UploadTask uploadTask = ref.putFile(file);

  try {
    await uploadTask;
    var downloadUrl = await ref.getDownloadURL();
    print("image link $downloadUrl");

     Map<String, String> data = {
    "id": FirebaseAuth.instance.currentUser!.uid,
    "Name": _nameController.text,
    "Profession": selectedSkill!,
    "Email": _emailController.text,
    "profile": downloadUrl // Use imageLink here
  };

    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(data)
      .then((_) {
    // Navigate to BnbPage after Firestore operation is complete
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Profile Created !"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BnbPage()),
      (route) => false,
    );
      });

    // Rest of your code to save the downloadUrl to Firestore...

  }
  on FirebaseAuthException catch (error) {
    print("Error uploading file: $error");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${error.message}"),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
    // Handle the error gracefully, e.g., show an error message to the user
  }
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

//   Future pickImage( context) async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//   _imageFile = File(pickedFile!.path);
//     // setState(() {
//     //   _imageFile = File(pickedFile.path);
//     // });
// uploadImageToFirebase(context);
//   }

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = basename(_imageFile!.path);
  //   Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
  //   await ref.putFile(File(fileName));
  //   ref.getDownloadURL().then((value){
  //     print("image link $value");
  //   });
  // }
}
