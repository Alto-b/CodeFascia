part of 'subscription_bloc.dart';

 class SubscriptionState extends Equatable {
  const SubscriptionState();
  
  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState{}

class SubscriptionLoadedState extends SubscriptionState{
  final List<SubscriptionModel> subscritpionList;

  SubscriptionLoadedState({
    required this.subscritpionList
  });
}

class SpecificSubsLoadedState extends SubscriptionState{
  final List<SubscriptionModel> specSubsList;
  SpecificSubsLoadedState({
    required this.specSubsList
  });
  @override
  List<Object> get props => [specSubsList];
}

class SearchLoadedState extends SubscriptionState{
  final List<SubscriptionModel> searchSubsList;
  SearchLoadedState({
    required this.searchSubsList
  });
  @override
  List<Object> get props => [searchSubsList];
}

class MySubscriptionErrorState extends SubscriptionState{}

class MySubscritpionsLoadedState  extends SubscriptionState{
  final List<BookingModel> mySubsList;
  // final List<SubscriptionModel> subsList;
  final UserModel userList;

  MySubscritpionsLoadedState({
    required this.mySubsList,
    // required this.subsList,
    required this.userList
  });
  @override
  List<Object> get props => [mySubsList,userList];
}