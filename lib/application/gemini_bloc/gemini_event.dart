part of 'gemini_bloc.dart';

sealed class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object> get props => [];
}

class ChatGenerateNewTextMessageEvent extends GeminiEvent{
  final String inputMessage;
  ChatGenerateNewTextMessageEvent({required this.inputMessage});
}
// @immutable
// sealed class GeminiEvent {}

// class ChatGenerateNewTextEvent extends GeminiEvent {
//   final String inputMessage;
//   ChatGenerateNewTextEvent({
//     required this.inputMessage,
//   });
// }