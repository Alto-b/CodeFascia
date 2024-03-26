import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.amber,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: () => AdaptiveTheme.of(context).setLight(),
            child: Container(
              // height: 30,width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              // child: Text("Light Mode",style: TextStyle(color: Colors.black),),
              child: const Icon(Icons.sunny,color: Colors.black,),
            ),
          ),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: () => AdaptiveTheme.of(context).setDark(),
            child: Container(
              // height: 30,width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              // child: Text("Dark Mode",style: TextStyle(color: Colors.white),),
              child: const Icon(Icons.nightlight_sharp,color: Colors.white,),
            ),
          ),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: () => AdaptiveTheme.of(context).setSystem(),
            child: Container(
              // height: 30,width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 77, 111, 204),
              ),
              
              // child: Text("System Mode"),
              child: const Icon(Icons.phone_android,color: Colors.white,),
            ),
          ),
          const SizedBox(height: 5,)
        ],
      ),
    );
  }
}