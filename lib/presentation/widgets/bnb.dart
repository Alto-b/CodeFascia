
import 'package:code_geeks/application/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/presentation/screens/community/community_chat.dart';
import 'package:code_geeks/presentation/screens/gemini/gemini.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:code_geeks/presentation/screens/settings/settings.dart';
import 'package:code_geeks/presentation/screens/signup/signup.dart';
import 'package:code_geeks/presentation/screens/subscriptions/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BnbPage extends StatelessWidget {
   BnbPage({super.key});

  int indexNum = 0;

  final screens = [
    HomePage(),
    CommunityPage(),
    SubscriptionsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BnbBloc, BnbState>(
      
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // print("builder tab ${state.tabIndex}");
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
                  BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.chat_rounded,),label: "Community"),
                  BottomNavigationBarItem(icon: Icon(Icons.subscriptions),label: "Subscriptions"),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label: "Settings"),
              ],
              showUnselectedLabels: false,
              showSelectedLabels: false,
              
              backgroundColor:  Color.fromARGB(255, 110, 132, 214),
              selectedIconTheme: IconThemeData(
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
        child: Image.asset('lib/assets/logo.png',
        fit: BoxFit.cover,
        ),
        tooltip: "AI Chat",
        splashColor: Colors.grey,
        shape: CircleBorder(),
        backgroundColor: Color.fromARGB(255, 110, 132, 214),)
    
        );
        }
        else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}