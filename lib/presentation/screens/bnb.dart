
import 'package:code_geeks/domain/bnb_bloc/bnb_bloc.dart';
import 'package:code_geeks/presentation/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BnbPage extends StatelessWidget {
   BnbPage({super.key});

  int indexNum = 0;

  final screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BnbBloc, BnbState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
    
          body: screens.elementAt(indexNum),
    
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                
              ),
              
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home),label: "a"),
                  BottomNavigationBarItem(icon: Icon(Icons.safety_check),label: "a"),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label: "a"),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label: "a"),
              ],
              showUnselectedLabels: true,
              backgroundColor: Colors.white70,
              selectedItemColor: Color.fromARGB(255, 110, 132, 214),
              unselectedItemColor: Colors.black45,
              showSelectedLabels: true,
              currentIndex: indexNum,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
               BlocProvider.of<BnbBloc>(context).add(TabChangeEvent(tabIndex: index));
                },
              ),
            ),
          ), 

        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Image.asset('lib/assets/logo.png',
        fit: BoxFit.cover,
        ),
        tooltip: "AI Chat",
        splashColor: Colors.grey,
        shape: CircleBorder(),
        backgroundColor: Color.fromARGB(255, 110, 132, 214),)
    
        );
      },
    );
  }
}