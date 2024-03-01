import 'package:code_geeks/application/subscription_bloc/subscription_bloc.dart';
import 'package:code_geeks/presentation/screens/subscriptions/subscriptions.dart';
import 'package:code_geeks/presentation/widgets/bnb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SpecificSubsPage extends StatefulWidget {
   SpecificSubsPage({super.key,required this.subsId});

  final subsId;

  @override
  State<SpecificSubsPage> createState() => _SpecificSubsPageState();
}

class _SpecificSubsPageState extends State<SpecificSubsPage> {

  @override
  void initState() {
    context.read<SubscriptionBloc>().add(SpecificSubsLoadEvent(SubsId: widget.subsId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    context.read<SubscriptionBloc>().add(SpecificSubsLoadEvent(SubsId: widget.subsId));

    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if(state is SpecificSubsLoadedState){
          return Scaffold(
    
            appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
             decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(state.specSubsList[0].photo),
                    fit: BoxFit.cover
                 ),
            ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 5,
                      child: IconButton(
                        style: ButtonStyle(
                          iconSize: MaterialStatePropertyAll(30),
                          iconColor:MaterialStatePropertyAll(Colors.white),

                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BnbPage()),
                            (route) => false,
                          );
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ],
                ),
              ),
              toolbarHeight: screenHeight / 5,
              backgroundColor: Colors.grey,
              
            ),

            
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(state.specSubsList[0].title,style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                        ),),
                        trailing: Text("₹ ${state.specSubsList[0].amount}/day"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(state.specSubsList[0].LangImg),
                          ),
                          tileColor: Colors.black12,
                          title: Text(state.specSubsList[0].language,style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                          ),),
                          trailing: IconButton(onPressed: (){
                            showDialog<void>(
                                          context: context,
                                          barrierDismissible: true, 
                                          barrierColor: Colors.black87,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              icon:Image.network(state.specSubsList[0].LangImg,height: 35,) ,
                                              title:  Text(state.specSubsList[0].language),
                                              content:  SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(state.specSubsList[0].LangDesc,style: TextStyle(fontSize: 20),),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Icon(Icons.arrow_back_ios_new),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                          }, icon: Icon(Icons.read_more)),
                        ),
                      ),
              
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.specSubsList[0].LangDesc,style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,fontSize: 18
                        ),),
                      ),
                      Divider(),
                      SizedBox(height: 60,),
                      
                      // Container(
                      //   width: screenWidth,
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //       backgroundColor: MaterialStatePropertyAll(Colors.green)
                      //     ),
                      //     onPressed: (){}, child: Text("Subscribe now",style: TextStyle(
                      //       color: Colors.white
                      //     ),))
                      //     )
                    ],
                  ),
                ),
              ),
            ),    
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              width: screenWidth,
              child: FloatingActionButton.extended(
                elevation: 5,
                backgroundColor: Colors.green,
                onPressed: (){

                }, label: Text("Subscribe Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),))),
         );
        }
        //if error loading the page --> shimmer
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios)),
            titleSpacing: 2,
            title: Text("back",style: TextStyle(
              fontSize: 15
            ),),
          ),
          body: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black
                    ),
                  ),SizedBox(height: 20,),
                  Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
        }

//         Future<void> _showLangDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(),
//         content: const SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('This is a demo alert dialog.'),
//               Text('Would you like to approve of this message?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Approve'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
}