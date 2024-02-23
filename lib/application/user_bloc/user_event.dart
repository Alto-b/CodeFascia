part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent{
}

class AddUserEvent extends UserEvent{
  final UserModel usermodel;
  AddUserEvent({required this.usermodel});
}

class UpdateUserEvent extends UserEvent{
  final UserModel usermodel;
  UpdateUserEvent({required this.usermodel});
}

class DeleteUserEvent extends UserEvent{
  final String userId;
  DeleteUserEvent({required this.userId});
}

