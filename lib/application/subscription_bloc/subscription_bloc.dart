import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks/domain/subscription_model.dart';
import 'package:code_geeks/infrastructure/subscription_repo.dart';
import 'package:equatable/equatable.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  SubscriptionBloc(this.subscriptionRepo) : super(SubscriptionInitial()) {
    
    on<SubscriptionLoadEvent>(getSubsriptions);
  }

  FutureOr<void> getSubsriptions(SubscriptionLoadEvent event, Emitter<SubscriptionState> emit)async{
    emit(SubscriptionInitial());
    final subs = await subscriptionRepo.getSubscriptions();
    emit(SubscriptionLoadedState(subscritpionList: subs));
  }

}
