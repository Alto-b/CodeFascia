part of 'subscription_bloc.dart';

 class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionLoadEvent extends SubscriptionEvent{}

class SpecificSubsLoadEvent extends SubscriptionEvent{
  String SubsId;
  SpecificSubsLoadEvent({
    required this.SubsId
  });
  @override
  List<Object> get props => [SubsId];
}

class SearchSubscriptionsEvent extends SubscriptionEvent{
  String searchWord;
  SearchSubscriptionsEvent({
    required this.searchWord
  });
  @override
  List<Object> get props => [searchWord];
}