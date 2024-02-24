import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks/domain/gemini_model.dart';
import 'package:code_geeks/infrastructure/gemini_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc() : super(GeminiSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);


    
  }

  List<GeminiMessageModel> messages = [];
  bool generating = false;

  Future<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event, Emitter<GeminiState> emit)async{
      messages.add(GeminiMessageModel(role: "user", parts: [
        GeminiPartModel(text: event.inputMessage)
      ]));
      emit(GeminiSuccessState(messages: messages));
  generating = true;
     String generatedText = await GeminiRepo.geminiTextGenerationRepo(messages);
     if(generatedText.isNotEmpty){
      generatedText = _parseText1(generatedText);
      generatedText = _parseText2(generatedText);
      messages.add(GeminiMessageModel(role: 'model', parts: [
        GeminiPartModel(text: generatedText)
      ]));
      emit(GeminiSuccessState(messages: messages));
     }
     generating = false;
    }
   String _parseText1(String text) {
    // Remove formatting characters
    return text.replaceAll("'''", '');
  }
  String _parseText2(String text) {
    // Remove formatting characters
    return text.replaceAll("*", '');
  }
}
