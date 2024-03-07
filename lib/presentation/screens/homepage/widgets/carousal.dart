
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarousal extends StatelessWidget {
  const HomeCarousal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: 200, 
          enlargeCenterPage: true, 
          aspectRatio: 16/9, 
          //aspectRatio: 4/3,
          enableInfiniteScroll: true,
          autoPlay: true, 
          autoPlayInterval: Duration(seconds: 2), 
          autoPlayAnimationDuration: Duration(milliseconds: 1000), 
          autoPlayCurve: Curves.fastOutSlowIn, 
          //autoPlayCurve: Curves.easeIn,
          enlargeStrategy: CenterPageEnlargeStrategy.height, 
        ),
        items: [
          // Add your carousel items here, e.g., Container, Image, or any widget
          Container(
            color: Colors.red,
            child: Center(child: Image.asset('lib/assets/logo.png')),
          ),
          Container(
            color: Colors.blue,
            child: Center(child: Image.asset('lib/assets/logo.png')),
          ),
          Container(
            color: Colors.green,
            child: Center(child: Image.asset('lib/assets/logo.png')),
          ),
        ],
      );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.blue,
//       child: CarouselSlider(
//         items: [
//           // Your carousel items here
//           Container(
//             color: Colors.red,
//             child: Center(child: Text('Slide 1')),
//           ),
//           Container(
//             color: Colors.green,
//             child: Center(child: Text('Slide 2')),
//           ),
//           Container(
//             color: Colors.blue,
//             child: Center(child: Text('Slide 3')),
//           ),
//         ],
//         options: CarouselOptions(
//           height: 200,
//           aspectRatio: 16 / 9,
//           viewportFraction: 0.8,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 3),
//           autoPlayAnimationDuration: Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: true,
//           scrollDirection: Axis.horizontal,
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 200.0;

//   @override
//   double get minExtent => 200.0;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomeScreen(),
//   ));
// }