part of 'gemini_bloc.dart';

// sealed class GeminiState extends Equatable {
//   const GeminiState();
  
//   @override
//   List<Object> get props => [];
// }

// final class GeminiInitial extends GeminiState {}

// final class GeminiSuccessState extends GeminiState{
//   final List<GeminiMessageModel> messages;
//   GeminiSuccessState({
//     required this.messages
//   });}

  
// }

@immutable
sealed class GeminiState {}

final class GeminiInitial extends GeminiState {}

class GeminiSuccessState extends GeminiState {
  final List<GeminiMessageModel> messages;
  GeminiSuccessState({
    required this.messages,
  });
}