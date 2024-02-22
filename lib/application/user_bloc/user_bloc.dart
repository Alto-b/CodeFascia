import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/firestore_services.dart';
import 'package:code_geeks/infrastructure/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final FireStoreServices _fireStoreServices;

  User? user = FirebaseAuth.instance.currentUser;

  UserBloc(this._fireStoreServices) : super(UserInitialState()) {
    on<LoadUserEvent>((event, emit)async {
      try{
        emit(UserLoadingState());
        final users = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user!.uid).snapshots();
        print(users);
      }catch(e){

      }
    });
  }
}
