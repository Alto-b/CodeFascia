import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/presentation/screens/subscriptions/specific_subs.dart';
import 'package:code_geeks/presentation/screens/subscriptions/widget/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    context.read<SubscriptionBloc>().add(SubscriptionLoadEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Subscriptions"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text("asd"),
        
              Container
              ( 
                // color: Colors.amber,
                height: screenHeight-200,
                width: screenWidth,
                child: SubscriptionCard(runtimeType: runtimeType, screenHeight: screenHeight, screenWidth: screenWidth),

              ),
              SizedBox(height: 450,)
            ],
          ),
        ),
      ),
    );
  }
}
