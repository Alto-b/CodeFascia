import 'package:code_geeks/presentation/screens/settings/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ModeButton extends StatelessWidget {
  const ModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => showPopover(context: context, 
                bodyBuilder: (context)=>MenuItems(),
                width: 90,
                height: 110,
                direction: PopoverDirection.bottom),
                child: Icon(Icons.light_mode),
    );
  }
}