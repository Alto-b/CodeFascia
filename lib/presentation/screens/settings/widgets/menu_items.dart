import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        GestureDetector(
          onTap: () => AdaptiveTheme.of(context).setLight(),
          child: Container(
            height: 20,
            color: Colors.white,
            child: Text("Light mode"),
          ),
        ),

        GestureDetector(
          onTap: () => AdaptiveTheme.of(context).setDark(),
          child: Container(
            height: 20,
            color: Colors.black,
            child: Text("Dark mode",style: TextStyle(color: Colors.white),),
          ),
        ),

        GestureDetector(
          onTap: () => AdaptiveTheme.of(context).setSystem(),
          child: Container(
            height: 20,
            color: Color.fromARGB(255, 59, 98, 206),
            child: Text("Sytem mode"),
          ),
        ),
      ],
    );
  }
}