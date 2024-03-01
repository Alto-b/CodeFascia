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
              toolbarHeight: screenHeight / 3,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(state.specSubsList[0].language,style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                          ),),
                          trailing: Text("₹ ${state.specSubsList[0].amount}"),
                        ),
                      ),
              
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.specSubsList[0].descritpion,style: TextStyle(
                          fontWeight: FontWeight.w400,fontSize: 15
                        ),),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.green)
                          ),
                          onPressed: (){}, child: Text("Subscribe now",style: TextStyle(
                            color: Colors.white
                          ),)))
                    ],
                  ),
                ),
              ),
            ),    
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
}