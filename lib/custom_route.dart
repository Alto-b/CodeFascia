// import 'package:flutter/material.dart';

// class CustomPageRoute<T> extends PageRouteBuilder<T> {
//   final WidgetBuilder builder;
//   final RouteSettings settings;

//   CustomPageRoute({
//     required this.builder,
//     required this.settings,
//   }) : super(
//           pageBuilder: (BuildContext context, Animation<double> animation,
//               Animation<double> secondaryAnimation) {
//             return builder(context);
//           },
//           transitionsBuilder: (BuildContext context,
//               Animation<double> animation,
//               Animation<double> secondaryAnimation,
//               Widget child) {
//             return child;
//           },
//           settings: settings,
//         );

//   @override
//   bool get opaque => false;

//   @override
//   bool get barrierDismissible => false;

//   @override
//   Duration get transitionDuration => Duration(milliseconds: 300);

//   @override
//   bool get allowSnapshotting => true; // Allow snapshotting
// }
