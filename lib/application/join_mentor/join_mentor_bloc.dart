import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

part 'join_mentor_event.dart';
part 'join_mentor_state.dart';

class JoinMentorBloc extends Bloc<JoinMentorEvent, JoinMentorState> {
  JoinMentorBloc() : super(JoinMentorInitial()) {
    on<FilePickerInitialEvent>((event, emit) {
      emit(JoinMentorInitial());
    },);
    on<FilePickerEvent>(pickFile);
    on<PlaceRequestEvent>(requestToFirebase);

  }

  FutureOr<void> pickFile(FilePickerEvent event, Emitter<JoinMentorState> emit)async{
     FilePickerResult?  pickedfile = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf']);
      if(pickedfile!=null){
        File file = File(pickedfile.files.first.path!);
        emit(FilePickedState(filePath: file));
      }
       }

  FutureOr<void> requestToFirebase(PlaceRequestEvent event, Emitter<JoinMentorState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("join_mentors")
      .doc(event.reqId)
      .set(event.data).then((value){
        debugPrint("MentorRequest successful");
      });
    }
    on FirebaseException catch(e){
      debugPrint("MentorRequest failed ${e.message}");
    }
  }
}
