
import 'package:CodeFascia/application/bnb_bloc/bnb_bloc.dart';
import 'package:CodeFascia/presentation/screens/gemini/gemini.dart';
import 'package:CodeFascia/presentation/screens/homepage/homepage.dart';
import 'package:CodeFascia/presentation/screens/post_page/feed_view.dart';
import 'package:CodeFascia/presentation/screens/settings/settings.dart';
import 'package:CodeFascia/presentation/screens/subscriptions/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BnbPage extends StatelessWidget {
   BnbPage({super.key});

  int indexNum = 0;

  final screens = [
    const HomePage(),
    const PostViewPage(),
    const SubscriptionsPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BnbBloc, BnbState>(
      
      listener: (context, state) {
      },
      builder: (context, state) {
        if(state is BnbInitial){
          return Scaffold(
          body: screens.elementAt(state.tabIndex),   
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                
              ),
              
              child: BottomNavigationBar(
                
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.feed_outlined,),label: "Feed"),
                  BottomNavigationBarItem(icon: Icon(Icons.subscriptions_outlined),label: "Subscriptions"),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: "Settings"),
              ],
              showUnselectedLabels: false,
              showSelectedLabels: false,
              
              backgroundColor:  const Color.fromARGB(255, 110, 132, 214),
              selectedIconTheme: const IconThemeData(
                size: 30,

              ),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.45),
              currentIndex: state.tabIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
               BlocProvider.of<BnbBloc>(context).add(TabChangeEvent(tabIndex: index));
               
                },
              ),
            ),
          ), 

        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => GeminiPage(),));
        },
        tooltip: "AI Chat",
        splashColor: Colors.grey,
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 110, 132, 214),
        child: Image.asset('lib/assets/logo.png',
        fit: BoxFit.cover,
        ),)
    
        );
        }
        else{
          return const CircularProgressIndicator();
        }
      },
    );
  }
}