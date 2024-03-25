
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
        print(state.runtimeType);
        if(state is MySubscritpionsLoadedState){
          return CarouselSlider(
                          options: CarouselOptions(
                            height: 150, 
                            enlargeCenterPage: true, 
                            aspectRatio: 3/3, 
                            //aspectRatio: 4/3,
                            enableInfiniteScroll: false,
                            autoPlay: true, 
                            autoPlayInterval: Duration(seconds: 2), 
                            autoPlayAnimationDuration: Duration(milliseconds: 1000), 
                            autoPlayCurve: Curves.fastOutSlowIn, 
                            //autoPlayCurve: Curves.easeIn,
                            enlargeStrategy: CenterPageEnlargeStrategy.height, 
                          ),
                          items: [
                            // // Add your carousel items here, e.g., Container, Image, or any widget
                            ListView.builder(
                              // scrollDirection: Axis.horizontal,
                              itemCount: state.mySubsList.length,
                              itemBuilder: (context, index) {
                               return Container(
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MySubscriptionsPage(),)),
                                    leading: CachedNetworkImage(imageUrl: state.mySubsList[index].sub_photo,fit: BoxFit.cover,width: screenWidth/6,),
                                    title: Text(state.mySubsList[index].sub_title),
                                    subtitle: Text(state.mySubsList[index].sub_lang) ,
                                    trailing: Icon(Icons.circle_outlined),
                                    
                                  ),
                                ),
                              );
                              },
                            ),
                          ],
                        );
        }
        return Text("No subscriptions");
      },
    );
  }
}
