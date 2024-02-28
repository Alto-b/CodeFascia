import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks/domain/language_model.dart';
import 'package:code_geeks/domain/mentor_model.dart';
import 'package:code_geeks/infrastructure/language_repo.dart';
import 'package:code_geeks/infrastructure/mentor_repo.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LanguageRepo langrep = LanguageRepo();
  MentorRepo mentorRepo = MentorRepo();
  HomeBloc(this.langrep,this.mentorRepo) : super(HomePageLoadingState()) {
    // on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<HomeLoadingEvent>(loadingHome);
    // on<LanguageLoadEvent>(loadingLanguage);
    // on<MentorLoadEvent>(loadingMentor);
    
  }

  

  FutureOr<void> loadingHome(HomeLoadingEvent event, Emitter<HomeState> emit)async{
    emit(HomePageLoadingState());
    final lang =await langrep.getlanguage();
    emit(LanguageLoadedState(languageList: lang));
    final mentor = await mentorRepo.getMentor();
    emit(MentorLoadedState(mentorList: mentor));
     emit(HomeContentLoadedState(lang, mentor));
    
  }

  // FutureOr<void> loadingLanguage(LanguageLoadEvent event, Emitter<HomeState> emit)async {
  //   // print("asd");
  //   emit(LanguageLoadingState());
  //  final lang =await langrep.getlanguage();
  //  print(lang);
  //   emit(LanguageLoadedState(languageList: lang));
  // }

  // FutureOr<void> loadingMentor(MentorLoadEvent event, Emitter<HomeState> emit) async{
  //   emit(MentorLoadingState());
  //   final mentor = await mentorRepo.getMentor();
  //   print(mentor);
  //   emit(MentorLoadedState(mentorList: mentor));
  // }
}
