import 'package:CodeFascia/application/home_page_bloc/home_bloc.dart';
import 'package:CodeFascia/presentation/screens/homepage/widgets/home_loading.dart';
import 'package:CodeFascia/presentation/screens/homepage/widgets/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeLoadingEvent());
    return Scaffold(

      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomePageLoadingState:
          return const HomeLoadingScreen();
            case HomePageLoadedState:
              return const HomeScreen();
            case HomePageErrorState:
              return const Center(child: Text("Error Loading HomePage"));
            default:
          }
          return const HomeScreen();
        },
      ),
    );
  }
}




