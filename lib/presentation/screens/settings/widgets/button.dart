import 'package:CodeFascia/presentation/screens/settings/widgets/menu_items.dart';
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
                bodyBuilder: (context)=>const MenuItems(),
                width: screenWidth/3,
                height: screenHeight/14,
                direction: PopoverDirection.bottom),
                child: const Icon(Icons.light_mode),
    );
  }
}