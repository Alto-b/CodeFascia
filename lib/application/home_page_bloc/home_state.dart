part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomePageLoadingState extends HomeState{}

class HomePageLoadedState extends HomeState{}

class HomePageErrorState extends HomeState{}
