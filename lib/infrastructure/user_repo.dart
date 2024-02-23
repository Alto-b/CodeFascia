import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserRepo{

  User? user = FirebaseAuth.instance.currentUser;

  Future<List<UserModel>> get()async{
  List<UserModel> userList=[]; print('entered repo');
  try{
    print("uid from repo${user!.uid}");
    final users = await FirebaseFirestore.instance.collection("users").where('id',isEqualTo:user!.uid).get();
    // print("users ${users}"); 
    users.docs.forEach((element) {
      // print("users1 ${users}");
      return userList.add(UserModel.fromJson(element.data()));
    }
    );
    return userList;
  }
  on FirebaseException catch(e){
    if(kDebugMode){
      print("failed with error ${e.code} : ${e.message}");
    }
    return userList;
  }
  catch(e){
    throw Exception(e.toString());
  }
}

}