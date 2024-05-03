import 'package:flutter/material.dart';

class CustomRoutes {
  static Route<dynamic> routeToScanner(Widget destinationPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
