part of 'join_mentor_bloc.dart';

sealed class JoinMentorState extends Equatable {
  const JoinMentorState();
  
  @override
  List<Object> get props => [];
}

final class JoinMentorInitial extends JoinMentorState {}

class FilePickedState extends JoinMentorState{
  final File filePath;

  const FilePickedState({
    required this.filePath
  });

  @override
  List<Object> get props => [filePath];
}
