part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserInitialState extends UserState {}

class UserLoadingState extends UserState{}

class UserLoadedState extends UserState{
  final List<UserModel> userList;

  UserLoadedState({required this.userList});
}

class UserSuccessState extends UserState{
  final String message;
  UserSuccessState({required this.message});
}

class UserErroState extends UserState{
  final String errorMessage;
  UserErroState({required this.errorMessage});
}
