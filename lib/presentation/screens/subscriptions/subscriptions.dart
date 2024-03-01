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
        // backgroundColor: Colors.grey,
        backgroundColor:  Color.fromARGB(255, 110, 132, 214),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22))
        ),
        toolbarHeight: (screenHeight/10)+10,
        // title: const Text("Browse Subscriptions"),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35)
            ),
            child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder( 
                          borderRadius: BorderRadius.circular(35)
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            //search button
                          },
                          child: Icon(Icons.search)),
                        suffixIcon: InkWell(
                          onTap: () {
                            //filter button
                          },
                          child: Icon(Icons.filter_list))
                      ),
                    ),
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                // child: TextFormField(

                //   decoration: InputDecoration(

                //     border: OutlineInputBorder(
                      
                //     ),
                //     prefixIcon: InkWell(
                //       onTap: () {
                //         //search button
                //       },
                //       child: Icon(Icons.search)),
                //     suffixIcon: InkWell(
                //       onTap: () {
                //         //filter button
                //       },
                //       child: Icon(Icons.filter_list))
                //   ),
                // ),
              ),
        
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
