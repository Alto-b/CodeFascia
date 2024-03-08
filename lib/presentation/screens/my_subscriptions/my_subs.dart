import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySubscriptionsPage extends StatelessWidget {
  const MySubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    context.read<SubscriptionBloc>().add(MySubscritpionLoadEvent(uid: currentUser));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Subscriptions"),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<SubscriptionBloc, SubscriptionState>(
                  builder: (context, state) {
                    if(state is MySubscritpionsLoadedState){
                      // UserModel user = state.userList;
                      return Container(
                                  height: screenHeight-screenHeight/7,
                                  width: screenWidth-40,
                                  // color: Colors.amber,
                                  child: ListView.builder(
                                    itemCount: state.mySubsList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: screenHeight/4,
                                          width: screenWidth-20,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey
                                            )
                                          ),                                         
                                          child: Column(               
                                            children: [
                                              Text(state.mySubsList[index].sub_id),
                                              
                                            ],
                                          ),
                                        ),
                                      );
                                    },),
                                );
                    }
                    else if(state is MySubscriptionErrorState){
                      return Text("No subscriptions");
                    }
                    return Text("Error loading subscriptions");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}