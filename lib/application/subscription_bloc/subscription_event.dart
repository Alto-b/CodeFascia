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
}