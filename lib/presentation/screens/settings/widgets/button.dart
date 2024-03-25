import 'package:code_geeks/presentation/screens/settings/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ModeButton extends StatelessWidget {
  const ModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(

      onTap: () => showPopover(context: context, 
                bodyBuilder: (context)=>MenuItems(),
                width: screenWidth/3,
                height: screenHeight/14,
                direction: PopoverDirection.bottom),
                child: Icon(Icons.light_mode),
    );
  }
}