import 'package:code_geeks/application/post_bloc/post_bloc.dart';
import 'package:code_geeks/presentation/screens/post_page/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class PostViewPage extends StatelessWidget {
  const PostViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    context.read<PostBloc>().add(FeedsLoadEvent());
    return Scaffold(

      appBar: AppBar(
        title: Text("FEED",style: GoogleFonts.orbitron(fontWeight: FontWeight.w700,color: Colors.grey,letterSpacing: 2),),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: screenWidth-20,
                height: screenHeight-(screenHeight/4.8),
                // color: Colors.amber,
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if(state is FeedLoadedState){
                      return ListView.builder(
                                  itemCount: state.postList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      // child: Container(
                                      //   height: screenHeight/7,
                                      //   child: InkWell(
                                      //     onTap: () {
                                            
                                      //     },
                                      //     child: Card(
                                      //       elevation: 5,
                                      //       child: ListTile(
                                      //         title: Text(state.postList[index].title,style: GoogleFonts.poppins(
                                      //           fontWeight: FontWeight.w600,
                                      //           fontSize: 20,
                                      //         ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      //         subtitle:Text("${state.postList[index].description} \n ${state.postList[index].content}",maxLines: 2,style: GoogleFonts.poppins(
                                      //               fontSize: 17,fontWeight: FontWeight.w300
                                      //             ),overflow: TextOverflow.ellipsis,),
                                      //           trailing: CircleAvatar(radius: 20,
                                      //             backgroundImage: NetworkImage(state.postList[index].author_avatar),
                                      //           ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificPostView(
                                            title: state.postList[index].title,
                                            author: state.postList[index].author,
                                            author_avatar: state.postList[index].author_avatar,
                                            content: state.postList[index].content,
                                            description: state.postList[index].description,
                                            ),));
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            height: (screenHeight/7)+10,
                                            width: screenWidth-20,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(radius: 10,backgroundImage: NetworkImage(state.postList[index].author_avatar),),
                                                      SizedBox(width: 10,),
                                                      Text(state.postList[index].author),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text(state.postList[index].title,style: GoogleFonts.poppins(
                                                    fontSize: 17,fontWeight: FontWeight.w700
                                                  ),),
                                                  SizedBox(height: 10,),
                                                  Text(state.postList[index].content,overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.poppins(
                                                    fontSize: 12,fontWeight: FontWeight.w400
                                                  ),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    );
                                
                                  },);
                    }
                    return  ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.grey.shade400,
                                      direction: ShimmerDirection.ttb,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: screenHeight/6,
                                          width: screenWidth-20,
                                          decoration: BoxDecoration(

                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(25)
                                          ),
                                        ),
                                      ),
                                    );
                                  },);
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}