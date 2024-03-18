import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/firestore_services.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:code_geeks/infrastructure/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  // final FireStoreServices _fireStoreServices;

  User? user = FirebaseAuth.instance.currentUser;

  UserRepo userRepo = UserRepo();

  UserBloc(this.userRepo) : super(UserInitialState()) {

    on<LoadUserEvent>((event, emit)async {
    //   try{
    //     emit(UserLoadingState());
    //     final users = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: user!.uid).snapshots();
    //     print(users);
    //   }catch(e){

    //   }

    emit(UserLoadingState());
      await Future.delayed(Duration(seconds: 1));
    try{
      // await Future.delayed(Duration(seconds: 1));
      final data = await userRepo.getUser();
      print("data from bloc : ${data}");
      emit(UserLoadedState(userList:data ));
    }
    on FirebaseException catch(e){
      // emit(UserErroState(errorMessage: "error loading user"));
      emit(UserErroState(errorMessage: "error loading user data ${e.message}"));
    }

     });


    
  }
}
