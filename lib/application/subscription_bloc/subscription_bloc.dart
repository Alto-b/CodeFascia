import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/booking_model.dart';
import 'package:code_geeks/domain/subscription_model.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:code_geeks/infrastructure/subscription_repo.dart';
import 'package:code_geeks/infrastructure/user_repo.dart';
import 'package:equatable/equatable.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  UserRepo userRepo = UserRepo();
  SubscriptionBloc(this.subscriptionRepo,this.userRepo) : super(SubscriptionInitial()) {
    
    on<SubscriptionLoadEvent>(getSubsriptions);
    on<SpecificSubsLoadEvent>(getSpecificSubs);
    on<SearchSubscriptionsEvent>(searchSubscriptions);
    on<BookSubscriptionEvent>(bookSubscritpion);
    on<MySubscritpionLoadEvent>(mySubscriptions);
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

  FutureOr<void> bookSubscritpion(BookSubscriptionEvent event, Emitter<SubscriptionState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("bookings")
      .doc(event.bookingId)
      .set(event.data).then((value){
        print("booking successful");
      });
    }
    on FirebaseException catch(e){
      print("bookingSubs ${e.message}");
    }
  }



  FutureOr<void> mySubscriptions(MySubscritpionLoadEvent event, Emitter<SubscriptionState> emit)async{
    final mySubs = await subscriptionRepo.mySubscriptions(event.uid);
    // final subs = await subscriptionRepo.getSpecificSubs(mySubs);
    final user = await userRepo.getUser();
    print("mysubs ${mySubs.length}");
    print("mysubsUsers ${user.id}");
    if(mySubs.length<=0){
      emit(MySubscriptionErrorState());
    }
   else{
     emit(MySubscritpionsLoadedState(mySubsList: mySubs, userList: user,));
   }
  }
}