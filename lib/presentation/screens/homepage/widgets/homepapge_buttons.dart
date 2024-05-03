
import 'package:flutter/material.dart';

class LogoCard extends StatelessWidget {
  const LogoCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.imagePath
  });

  final double screenHeight;
  final double screenWidth;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("logo pressed");
      },
      child: Card(
        color: Colors.grey.shade200,
        elevation: 5,
        child: Container(
          height: screenHeight/13,
          width: screenWidth/6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // color: Colors.amber,
          ),
          child: Image.asset(imagePath,filterQuality:FilterQuality.high,fit: BoxFit.scaleDown,)
        ),
      ),
    );
  }
}
