import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
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
        title: const Text("Subscriptions"),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text("asd"),
        
              Container(
                height: screenHeight,
                width: screenWidth,
                child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if(state is SubscriptionLoadedState){
                      return GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                  itemCount: state.subscritpionList.length,
                                  itemBuilder: (context, index) {
                                  return  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(image: NetworkImage(state.subscritpionList[index].photo))
                                              ),
                                            ),
                                          ),
                                          Text(state.subscritpionList[index].title)
                                        ],
                                      ),
                                    )
                                  );
                                },);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}