import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/application/join_mentor/join_mentor_bloc.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;

class MentorJoinPage extends StatelessWidget {
   MentorJoinPage({super.key});

  final _key = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _contact = TextEditingController();
   File? cv ;

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
              const SizedBox(height: 20,),
              Text("Join Us",style: GoogleFonts.orbitron(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),),
              const SizedBox(height: 20,),
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
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: _name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: const Text("Full name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        TextFormField(
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: const Text("Email id"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        TextFormField(
                          controller: _contact,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: const Text("Contact"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        TextFormField(
                          controller: _about,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 10,
                          decoration: InputDecoration(
                            label: const Text("About"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                          ),
                        ),const SizedBox(height: 20,),
                        BlocBuilder<JoinMentorBloc, JoinMentorState>(
                          builder: (context, state) {
                            print(state.runtimeType);
                            if(state is FilePickedState){
                              cv = state.filePath;
                              String fileName = File(cv!.path).path.split('/').last;
                              print(cv);
                              return TextButton.icon(onPressed: (){
                                context.read<JoinMentorBloc>().add(FilePickerEvent());
                              }, icon: Icon(Icons.edit), label:Text(fileName));//i need name of file here
                            }
                             return TextButton.icon(onPressed: (){
                                         context.read<JoinMentorBloc>().add(FilePickerEvent());
                                        }, icon: const Icon(Icons.file_copy_outlined), label: const Text("upload CV"));
                          },
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          print(cv);
                          sendRequestToJoinAsMEntor(context);
                        },style: ButtonStyle(
                          backgroundColor:MaterialStatePropertyAll(Colors.green[400])
                        ), child: const Text("Submit",style: TextStyle(
                          color: Colors.white
                        ),),),
                        const SizedBox(height: 20,),
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

  void sendRequestToJoinAsMEntor(BuildContext context)async{
    if(cv==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CV is required"),backgroundColor: Colors.blue,));;
    }
    else if(_key.currentState!.validate() && cv!=null){
      firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref().child("cv_${_name.text}.pdf");
      firebasestorage.UploadTask uploadTask = ref.putFile(cv!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,duration: Duration(seconds: 2),));
      await uploadTask;
      var downloadUrl = await ref.getDownloadURL();

      final reqId = FirebaseFirestore.instance.collection("mentor_requests").doc().id;
      
      Map<String,dynamic> data ={
        "reqId" : reqId,
        "Name" : _name.text.trim(),
        "Email" : _email.text.trim(),
        "Contact" : _contact.text.trim(),
        "About" : _about.text.trim(),
        "CV" : downloadUrl
      };
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request placed!"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
     context.read<JoinMentorBloc>().add(PlaceRequestEvent(data: data, reqId: reqId)); 
     Future.delayed(Duration(seconds: 2));
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BnbPage(),), (route) => false);
    }
  }
}