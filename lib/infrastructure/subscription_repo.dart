import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/subscription_model.dart';
import 'package:flutter/material.dart';

class SubscriptionRepo{

  Future<List<SubscriptionModel>> getSubscriptions() async{

    List<SubscriptionModel> subscriptionList = [];

    try{
      final datas = await FirebaseFirestore.instance.collection("subscriptions").get();
      datas.docs.forEach((element) {
        final data = element.data();
        final subscription = SubscriptionModel(
          subsId: data['SubsId'],
          title: data['title'], 
          language: data['language'], 
          descritpion: data['description'], 
          photo: data['photo'], 
          amount: data['amount']);

          subscriptionList.add(subscription);
      });
      return subscriptionList;
    }
   on FirebaseException catch(e){
      debugPrint("expection getting subscritpions. : ${e.message}");
    }
    return subscriptionList;
  }


  Future<List<SubscriptionModel>> getSpecificSubs(String subsId)async{
    List<SubscriptionModel> specSubsList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection("subscriptions").where('SubsId',isEqualTo: subsId).get();
      datas.docs.forEach((element) {
        final data = element.data();
        final specSubs = SubscriptionModel(
          subsId: subsId, 
          title: data['title'], 
          language: data['language'], 
          descritpion: data['description'], 
          photo: data['photo'], 
          amount: data['amount']);

          specSubsList.add(specSubs);
      });
      return specSubsList;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting specific subscritpions. : ${e.message}");
    }
    return specSubsList;
  }
}