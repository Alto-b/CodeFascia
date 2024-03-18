import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_geeks/application/home_page_bloc/home_bloc.dart';
import 'package:code_geeks/login_check.dart';
import 'package:code_geeks/presentation/screens/homepage/widgets/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeLoadingEvent());
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      // appBar: AppBar(
      //  leading: CircleAvatar(
        
      //  ),
      // ),

      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case HomePageLoadingState:
           return Shimmer.fromColors(
            baseColor: Colors.transparent,
            highlightColor: Colors.grey.shade500,
            child: HomeScreen());
              
            case HomePageLoadedState:
              return HomeScreen();
            case HomePageErrorState:
              return Center(child: Text("Error Loading HomePage"));
            default:
          }
          return HomeScreen();
        },
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Image.asset('lib/assets/logo.png',
      //   fit: BoxFit.cover,
      //   ),
      //   tooltip: "AI Chat",
      //   splashColor: Colors.grey,
      //   shape: CircleBorder(),
      //   backgroundColor: Color.fromARGB(255, 110, 132, 214),)
    );
  }
}




