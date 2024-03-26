
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/presentation/screens/my_subscriptions/my_subs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingSubsSlider extends StatelessWidget {
  const OngoingSubsSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    context.read<SubscriptionBloc>().add(MySubscritpionLoadEvent(uid: FirebaseAuth.instance.currentUser!.uid));
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if(state is MySubscritpionsLoadedState){
         return SizedBox(
                            height: screenHeight/8,
                            width: screenWidth,
                            child: CarouselSlider.builder(
                                    itemCount: state.mySubsList.length,
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(seconds: 2),
                                      enlargeCenterPage: true,
                                      pauseAutoPlayOnTouch: true,
                                      animateToClosest: true,
                                    ),
                                    itemBuilder: (context, index, realIndex) {
                                      return ListTile(
                                        shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        tileColor: Colors.white,
                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MySubscriptionsPage(),)),
                                      textColor: Colors.black,
                                      leading: CachedNetworkImage(imageUrl: state.mySubsList[index].sub_photo,fit: BoxFit.cover,width: screenWidth/6,),
                                      title: Text(state.mySubsList[index].sub_title),
                                      subtitle: Text(state.mySubsList[index].sub_lang) ,
                                      trailing: ((state.mySubsList[index].status) == "ongoing") ?
                                      const Icon(Icons.circle,size: 15,color: Colors.green,) :  const Icon(Icons.circle,size: 15,color: Colors.amber,)                
                                  );
                                    },
                                  ),
                          );
        }
        return const Text("No subscriptions");
      },
    );
  }
}
