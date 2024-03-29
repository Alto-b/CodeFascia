import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CodeFascia/domain/user_model.dart';

class FireStoreServices{
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Stream<List<UserModel>> getUser(){
    return _userCollection.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        return UserModel(
          id: doc.id, 
          name: data['name'], 
          email: data['email'], 
          profile: data['profile'],
          profession: data['profession']);
      }).toList();
    });
  }

  Future<void> addUser(UserModel usermodel){
    return _userCollection.add({
      'id' : usermodel.id,
      'name' : usermodel.name,
      'email' : usermodel.email,
      'profile' : usermodel.profile,
      'profession': usermodel.profession
    });
  }

  Future<void> updateUser(UserModel usermodel){
    return _userCollection.doc(usermodel.id).update({
      'name' : usermodel.name,
      'email' : usermodel.email,
      'profile' : usermodel.profile,
      'profession': usermodel.profession
    });
  }

  Future<void> userDelete(String userId){
    return _userCollection.doc(userId).delete();
  }

}