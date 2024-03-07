import 'package:code_geeks/application/home_page_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MentorsPage extends StatelessWidget {
  const MentorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(),

      body: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print(state.runtimeType);
         if(state is HomeContentLoadedState){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                      Text("Meet our mentors",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,),),
            
                      SizedBox(height: 20,),
              
                  Container(
                                height: (screenHeight)-150,
                                width: screenWidth,
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: screenHeight/3), 

                                  itemCount: state.mentorList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        height: screenHeight/3,
                                        width: screenWidth/2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey
                                          ),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: screenHeight/5,
                                          width: screenWidth/2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                                          ),
                                          child: Image.network(state.mentorList[index].photo,fit: BoxFit.cover,
                                          ),
                                        ),
                                        // Text(state.mentorList[index].name)
                                        ListTile(
                                          title: Text(state.mentorList[index].name,style: TextStyle(fontWeight: FontWeight.w600)),
                                          subtitle: Text(state.mentorList[index].qualification,style: TextStyle(fontWeight: FontWeight.w500)),
                                        )
                                          ],
                                        ),
                                      ),
                                    );
                                  },)
                              )
                ],
              ),
            ),
          );
          
        }
        return SizedBox();
      },
    )

    );
  }
}