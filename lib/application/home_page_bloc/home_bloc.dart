import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomePageLoadingState()) {
    // on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<HomeLoadingEvent>(loadingHome);
  }

  

  FutureOr<void> loadingHome(HomeLoadingEvent event, Emitter<HomeState> emit)async{
    emit(HomePageLoadingState());
    print(1);
    await Future.delayed(Duration(seconds: 2));
    print(2);
    emit(HomePageLoadedState());
  }
}
