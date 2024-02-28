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
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                radius: 40,
                                // child: Image.network(state.languageList[index].photo),
                                backgroundImage: NetworkImage(state.languageList[index].photo),
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