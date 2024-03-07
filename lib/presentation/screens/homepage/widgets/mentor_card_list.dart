
import 'package:code_geeks/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks/presentation/screens/mentors/mentors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MentorCardHPWidget extends StatelessWidget {
  const MentorCardHPWidget({
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Meet our mentors",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,),),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MentorsPage(),));
                  }, icon: Icon(Icons.keyboard_arrow_right_rounded))
                ],
              ),
              Container(
                            height: (screenHeight/4)+20,
                            width: screenWidth,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.mentorList.length,
                              itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Card(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(width: 1,color: Colors.grey.shade800),),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    height: screenHeight/6,
                                    width: screenWidth/3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: screenHeight/6,
                                          width: screenWidth/3,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                          ),
                                          child: Image.network(state.mentorList[index].photo,fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Text(state.mentorList[index].name,style: TextStyle(fontWeight: FontWeight.w500),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(state.mentorList[index].qualification),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },)
                          ),
            ],
          );
          
        }
        return SizedBox();
      },
    );
  }
}
