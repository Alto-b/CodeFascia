import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      decoration: BoxDecoration(
        color: Colors.grey
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () => AdaptiveTheme.of(context).setLight(),
            child: Container(
              height: 30,width: 90,
              color: Colors.white,
              child: Text("Light Mode",style: TextStyle(color: Colors.black),),
            ),
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () => AdaptiveTheme.of(context).setDark(),
            child: Container(
              height: 30,width: 90,
              color: Colors.black,
              child: Text("Dark Mode",style: TextStyle(color: Colors.white),),
            ),
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () => AdaptiveTheme.of(context).setSystem(),
            child: Container(
              height: 30,width: 90,
              color: Color.fromARGB(255, 59, 98, 206),
              child: Text("System Mode"),
            ),
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}