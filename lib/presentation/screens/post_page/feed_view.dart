import 'package:CodeFascia/application/post_bloc/post_bloc.dart';
import 'package:CodeFascia/presentation/screens/post_page/post_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
          title: Text(
            "FEED",
            style: GoogleFonts.orbitron(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 2),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth - 20,
                  height: screenHeight - (screenHeight / 4.8),
                  // color: Colors.amber,
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is FeedLoadedState) {
                        if (state.postList.isEmpty) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Lottie.asset('lib/assets/no_posts.json'),
                                Text(
                                  "No posts are available at the moment",
                                  style: GoogleFonts.orbitron(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ));
                        }
                        // @override
                        // Widget build(BuildContext context) {
                        //   return Scaffold(
                        //     body: AnimationLimiter(
                        //       child: ListView.builder(
                        //         itemCount: 100,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return AnimationConfiguration.staggeredList(
                        //             position: index,
                        //             duration: const Duration(milliseconds: 375),
                        //             child: SlideAnimation(
                        //               verticalOffset: 50.0,
                        //               child: FadeInAnimation(
                        //                 child: YourListChild(),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   );
                        // }

                        // return ListView.builder(
                        //   itemCount: state.postList.length,
                        //   itemBuilder: (context, index) {
                        //     return Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: GestureDetector(
                        //           onTap: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       SpecificPostView(
                        //                     title: state.postList[index].title,
                        //                     author:
                        //                         state.postList[index].author,
                        //                     author_avatar: state
                        //                         .postList[index].author_avatar,
                        //                     content:
                        //                         state.postList[index].content,
                        //                     description: state
                        //                         .postList[index].description,
                        //                   ),
                        //                 ));
                        //           },
                        //           child: Hero(
                        //             tag: state.postList[index].title,
                        //             child: SingleChildScrollView(
                        //               child: Card(
                        //                 elevation: 5,
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(25),
                        //                   ),
                        //                   height: (screenHeight / 7) + 10,
                        //                   width: screenWidth - 20,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(10.0),
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         Row(
                        //                           children: [
                        //                             CircleAvatar(
                        //                               radius: 10,
                        //                               backgroundImage:
                        //                                   NetworkImage(state
                        //                                       .postList[index]
                        //                                       .author_avatar),
                        //                             ),
                        //                             const SizedBox(
                        //                               width: 10,
                        //                             ),
                        //                             Text(state.postList[index]
                        //                                 .author),
                        //                           ],
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 10,
                        //                         ),
                        //                         Text(
                        //                           state.postList[index].title,
                        //                           style: GoogleFonts.poppins(
                        //                               fontSize: 17,
                        //                               fontWeight:
                        //                                   FontWeight.w700,
                        //                               // color: Colors.black,
                        //                               decoration:
                        //                                   TextDecoration.none),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 10,
                        //                         ),
                        //                         Text(
                        //                           state.postList[index].content,
                        //                           overflow:
                        //                               TextOverflow.ellipsis,
                        //                           maxLines: 2,
                        //                           style: GoogleFonts.poppins(
                        //                               fontSize: 12,
                        //                               fontWeight:
                        //                                   FontWeight.w400),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ));
                        //   },
                        // );
                        return ListView.builder(
                          itemCount: state.postList.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: Duration(milliseconds: 800),
                                child: SlideAnimation(
                                    verticalOffset: 100,
                                    child: FadeInAnimation(
                                        child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificPostView(
                                                title:
                                                    state.postList[index].title,
                                                author: state
                                                    .postList[index].author,
                                                author_avatar: state
                                                    .postList[index]
                                                    .author_avatar,
                                                content: state
                                                    .postList[index].content,
                                                description: state
                                                    .postList[index]
                                                    .description,
                                              ),
                                            ));
                                      },
                                      child: Hero(
                                        tag: state.postList[index].title,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Card(
                                              elevation: 5,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                height: (screenHeight / 7) + 10,
                                                width: screenWidth - 20,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 10,
                                                            backgroundImage:
                                                                NetworkImage(state
                                                                    .postList[
                                                                        index]
                                                                    .author_avatar),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(state
                                                              .postList[index]
                                                              .author),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        state.postList[index]
                                                            .title,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                // color: Colors.black,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        state.postList[index]
                                                            .content,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))));
                          },
                        );
                      }
                      // return Opacity(
                      //   opacity: 0.2,
                      //   child: Container(
                      //     child: Lottie.asset('lib/assets/loader.json'),
                      //   ),
                      // );
                      return const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.blueGrey,
                          radius: 25,
                        ),
                      );
                      // return ListView.builder(
                      //   itemCount: 4,
                      //   itemBuilder: (context, index) {
                      //     return Shimmer.fromColors(
                      //       baseColor: Colors.grey,
                      //       highlightColor: Colors.grey.shade400,
                      //       direction: ShimmerDirection.ttb,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Container(
                      //           height: screenHeight / 6,
                      //           width: screenWidth - 20,
                      //           decoration: BoxDecoration(
                      //               color: Colors.amber,
                      //               borderRadius: BorderRadius.circular(25)),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
