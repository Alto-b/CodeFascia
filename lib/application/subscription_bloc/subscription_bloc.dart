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
    on<SpecificSubsLoadEvent>(getSpecificSubs);
    on<SearchSubscriptionsEvent>(searchSubscriptions);
  }

  FutureOr<void> getSubsriptions(SubscriptionLoadEvent event, Emitter<SubscriptionState> emit)async{
    // emit(SubscriptionInitial());
    final subs = await subscriptionRepo.getSubscriptions();
    emit(SubscriptionLoadedState(subscritpionList: subs));
  }


  FutureOr<void> getSpecificSubs(SpecificSubsLoadEvent event, Emitter<SubscriptionState> emit)async {
    final specSubs = await subscriptionRepo.getSpecificSubs(event.SubsId);
    emit(SpecificSubsLoadedState(specSubsList: specSubs));
  }

  FutureOr<void> searchSubscriptions(SearchSubscriptionsEvent event, Emitter<SubscriptionState> emit)async{
    // final searchSubs = await subscriptionRepo.searchSubscriptions(event.searchWord);
    // emit(SearchLoadedState(searchSubsList: searchSubs));
    try{
      if(event.searchWord.isNotEmpty){
        print("bloc spec subs evnt start");
        print(event.searchWord);
        final searchSubs = await subscriptionRepo.searchSubscriptions(event.searchWord);
        print(searchSubs);
        // emit(SubscriptionLoadedState(subscritpionList: searchSubs));
        print("emitted");
        emit(SearchLoadedState(searchSubsList: searchSubs));
        
      }
      else{
        print("bloc all subs evnt start");
        final subs = await subscriptionRepo.getSubscriptions();
        emit(SubscriptionLoadedState(subscritpionList: subs));
      }
    }
    catch(e){
      print("searchSubs${e.toString()}");
    }
  }
}
