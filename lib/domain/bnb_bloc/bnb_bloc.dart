import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'bnb_event.dart';
part 'bnb_state.dart';

class BnbBloc extends Bloc<BnbEvent, BnbState> {
  BnbBloc() : super(BnbInitial(tabIndex: 0)) {
    on<BnbEvent>((event, emit) {
      if(event is TabChangeEvent){
        print(event.tabIndex);
        emit(BnbInitial(tabIndex: event.tabIndex));
        print(event.tabIndex);
      }
    });
  }
}
