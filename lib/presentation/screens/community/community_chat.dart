import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          AdaptiveTheme.of(context).toggleThemeMode();
        }, icon: Icon(Icons.light_mode_outlined))],
      ),
    );
  }
}