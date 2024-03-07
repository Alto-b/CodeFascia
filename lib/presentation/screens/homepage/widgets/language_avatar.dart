import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_geeks/application/home_page_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class language_avatars extends StatelessWidget {
  const language_avatars({
    super.key,
    required this.runtimeType,
    required this.screenHeight,
    required this.screenWidth,
  });

  final Type runtimeType;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print(state.runtimeType);
        if(state is HomeContentLoadedState){
          return Container(
                        // color: Colors.grey[300],
                        height: screenHeight/6,width: screenWidth,
                        
                        child: ListView.builder(
                          itemCount: state.languageList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                          return  Padding(
                            padding: EdgeInsets.all(12),
                            child:GestureDetector(
                              onTap: () {
                                print("tapped");
                              },
                              child:InkWell(
                                onTap: () {
                                  ///////////////
                                  showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              elevation: 5,
                                              clipBehavior: Clip.antiAlias,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: screenHeight,
                                                  // color: Colors.amber,
                                                  child: Center(
                                                    child: SingleChildScrollView(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            // Text(state.languageList[index].name),
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage(state.languageList[index].photo),
                                                            ),
                                                            SizedBox(height: 20,),
                                                             Text(state.languageList[index].description,style: TextStyle(fontSize: 20),),
                                                            // ElevatedButton(
                                                            //   child: const Text('Close BottomSheet'),
                                                            //   onPressed: () => Navigator.pop(context),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                  //////////////
                                },
                                child: ClipOval(
                                    child: Container(
                                      width: 50,
                                      height: 50, // Set a specific height to ensure it's a perfect circle
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(width: 0.1,color: Colors.grey),
                                        shape: BoxShape.circle,
                                      ),
                                      child:CachedNetworkImage(
                                        filterQuality: FilterQuality.high,
                                        fadeOutDuration: Duration(seconds: 1),
                                        imageUrl: state.languageList[index].photo),
                                    ),
                                  ),
                              ),

                            )
                          );
                        },),
                      );
        }
        //circle avatar is loading
        else if (state is LanguageLoadingState){
          return Container(
                        // color: Colors.grey[300],
                        height: screenHeight/6,width: screenWidth,
                        child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                          return  Padding(
                            padding: EdgeInsets.all(12),
                            //shimmer
                            child:Shimmer.fromColors(
                              baseColor: Colors.transparent,
                              highlightColor: Colors.grey,
                              direction: ShimmerDirection.ltr,
                              period: Duration(seconds: 2),
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey.withOpacity(0.5),
                                radius: 40,
                                // child: Image.network(state.languageList[index].photo),
                                // backgroundImage: NetworkImage(state.languageList[index].photo),
                              ),
                            )
                          );
                        },),
                      ); 
        }
        return SizedBox();
      },
    );
  }
}