import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserRepo{

  User? user = FirebaseAuth.instance.currentUser;

//   Future<List<UserModel>> get()async{
//   List<UserModel> userList=[]; print('entered repo');
//   try{
//     print("uid from repo${user!.uid}");
//     // final users = await FirebaseFirestore.instance.collection("users").where('id',isEqualTo:user!.uid).get();
//     final users = await FirebaseFirestore.instance.collection("users").doc('6CjPm9XzheX1lggRoNmCQSH5dBo2').get();
//     print("users ${users}"); 
//     final usera = users.data();
//     // users.docs.forEach((element) {
//     //   print("users1 ${users}");
//     //   return userList.add(UserModel.fromJson(element.data()));
//     // }
//     // );
//     return userList;
//   }
//   on FirebaseException catch(e){
//     if(kDebugMode){
//       print("failed with error ${e.code} : ${e.message}");
//     }
//     return userList;
//   }
//   catch(e){
//     throw Exception(e.toString());
//   }
// }


  
  Future<UserModel> getUser()async{
  try{
    final data = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    final usera = data.data();
    final users = UserModel(id: usera!['id'], name: usera['Name'], email: usera['Email'], profile: usera['profile'], profession: usera['Profession']);
    return users;
  }
  on FirebaseException catch(e){
    if(kDebugMode){
      print("failed with error ${e.code} : ${e.message}");
    }
    return UserModel(id: "", name: "", email: "", profile: "", profession: "");
  }
  catch(e){
    throw Exception(e.toString());
  }
}



}