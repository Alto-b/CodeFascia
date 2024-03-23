import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:code_geeks/application/user_bloc/user_bloc.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:code_geeks/presentation/screens/settings/settings.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(
        title: Text("My profile",style: GoogleFonts.orbitron(fontSize: 15,fontWeight: FontWeight.w600,letterSpacing: 4,color: Colors.grey),),
        // centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if(state is UserLoadedState){
                  UserModel data = state.userList;
                  _nameController.text = data.name;
                  _emailController.text = data.email;
                  selectedSkill = data.profession;
                  return Card(
                  elevation: 5,
                  shadowColor: Colors.black,
        
                  //back box
                  child: SingleChildScrollView(
                    child: Container(
                            // color: Colors.blue,
                            height: screenHeight-150,
                            width: screenWidth-20,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Text(data.email),
                                  SizedBox(height: 30,),
                                  // ProfileCard(user: user),
                       //image picker
                       BlocBuilder<ImagePickerBloc,ImagePickerState>(
                        builder: (context,state){
                         if(state.file==null){
                              return InkWell(
                                onTap: () {
                                  context.read<ImagePickerBloc>().add(GalleryPicker());
                                  newImge = state.file;
                                  
                                },
                                child:  Stack(
                                  children: [
                                    ClipRRect(
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(data.profile),
                                        
                                        ),
                                    ),
                                      Positioned(
                                        bottom: 15,right: 15,
                                        child: Icon(Icons.mode_edit_outline_outlined,color: Colors.white,)),
                                  ],
                                ),
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
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(child: Column(
                                      children: [
                                        TextFormField(
                                           controller: _nameController,
                                           decoration: const InputDecoration(
                                           border: OutlineInputBorder(),
                                          label: Text("Name")
                                        ),
                                     ),
                                     SizedBox(height: 20,),
                                      TextFormField(
                                           controller: _emailController,
                                           readOnly: true,
                                           decoration: const InputDecoration(
                                           border: OutlineInputBorder(),
                                          label: Text("email")
                                        ),
                                     ),
                                     SizedBox(height: 20,),
                                     DropdownButtonFormField2<String>(
                                        validator: (value) {
                                          if(value == null){
                                            return 'Please enter your profession';
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        value: data.profession,
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
                                          return ElevatedButton(onPressed: (){
                                              updateProfile(context,state.file!.path.toString());
                                           }, child: Text("Update"));
                                        },
                                      )
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                );
                }
                else{
                  return Center(child: Lottie.asset('lib/assets/loader.json',height: 120,width: 120));
                }
              },
            ),
          
          ),
        ),
      ),
    );
  }
 Future<void> updateProfile(BuildContext context,String newImg)async{
  File file = File(newImg);

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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BnbPage()),
      (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Profile updated"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
      });

    // Rest of your code to save the downloadUrl to Firestore...

  } catch (error) {
    print("Error uploading file: $error");
    // Handle the error gracefully, e.g., show an error message to the user
  }

 }
}