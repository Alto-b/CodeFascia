import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeedBackPage extends StatelessWidget {
   FeedBackPage({super.key});

  TextEditingController _feedbackController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback"),),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("Write to us !"),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key:_key,
                child: Column(
                children: [
                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    controller: _feedbackController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
              
                      )
                    ),
                    maxLines: 15,
                  ),
                  SizedBox(height: 20,),
                  ActionChip(label: Icon(Icons.send),onPressed: () {
                    if(_key.currentState!.validate()){
                      sendFeedback(context);
                    }
                  },)
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  void sendFeedback(BuildContext context)async{
    Map<String,String?> data = {
      "Email" : FirebaseAuth.instance.currentUser?.email,
      "Feedback" : _feedbackController.text.trim()
    };
    await FirebaseFirestore.instance.
    collection("Feedbacks")
    .doc()
    .set(data)
    .then((value){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Feedback Submitted"),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BnbPage()),
      (route) => false,
    );
    });
  }

}