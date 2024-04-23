import 'package:CodeFascia/application/subscription_bloc/subscription_bloc.dart';
import 'package:CodeFascia/presentation/screens/subscriptions/specific_subs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.runtimeType,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  final Type runtimeType;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    context.read<SubscriptionBloc>().add(SubscriptionLoadEvent());
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if(state is SubscriptionLoadedState){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: (screenHeight/3)+40),
              itemCount: state.subscritpionList.length,
              itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight/8,
                            width: screenWidth/2,
                            // child: Image.network(state.subscritpionList[index].photo,filterQuality: FilterQuality.high,fit: BoxFit.fill,),
                            child: CachedNetworkImage(imageUrl: state.subscritpionList[index].photo,filterQuality: FilterQuality.high,fit: BoxFit.cover,
                            placeholder: (context, url) => Icon(Icons.browse_gallery_outlined),),
                          ),
                          ListTile(
                            title: Text(state.subscritpionList[index].title,
                              style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.subscritpionList[index].language,),
                                const SizedBox(height: 10,),
                                Text(state.subscritpionList[index].description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                                
                              ],
                            ),
                            ),
    
                        const SizedBox(height: 20,),
    
                        ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  SpecificSubsPage(subsId: state.subscritpionList[index].subsId),));
                        },style: const ButtonStyle(
                          backgroundColor:MaterialStatePropertyAll(Colors.green),elevation: MaterialStatePropertyAll(5),overlayColor: MaterialStatePropertyAll(Colors.grey)
                        ), child: const Text("View More",style: TextStyle(
                          color: Colors.white
                        ),),),
                        
                        const SizedBox(height: 10,)
                            
                        ],
                      ),
                    ),
                  );
              },
              
            );
        }
        else if (state is SearchLoadedState){
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: (screenHeight/3)+40),
              itemCount: state.searchSubsList.length,
              itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight/8,
                            width: screenWidth/2,
                            child: Image.network(state.searchSubsList[index].photo,filterQuality: FilterQuality.high,fit: BoxFit.fill,),
                          ),
                          ListTile(
                            title: Text(state.searchSubsList[index].title,
                              style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.searchSubsList[index].language,),
                                const SizedBox(height: 10,),
                                Text(state.searchSubsList[index].description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                                
                              ],
                            ),
                            ),
    
                        const SizedBox(height: 20,),
    
                        ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  SpecificSubsPage(subsId: state.searchSubsList[index].subsId),));
                        },style: const ButtonStyle(
                          backgroundColor:MaterialStatePropertyAll(Colors.green),elevation: MaterialStatePropertyAll(5),overlayColor: MaterialStatePropertyAll(Colors.grey)
                        ), child: const Text("View More",style: TextStyle(
                          color: Colors.white
                        ),),),
                        
                        const SizedBox(height: 10,)
                            
                        ],
                      ),
                    ),
                  );
              },
              
            );
        }
        //gridview for not loaded state
        return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: (screenHeight/3)+40),
              itemCount: 4,
              itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            SizedBox( 
                              height: screenHeight/8,
                              width: screenWidth/2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              },
            );
      },
    );
  }
}