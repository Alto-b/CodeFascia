
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
            //color: Colors.red,
            child: Center(child: Image.asset('lib/assets/logo.png')),
          ),
          Container(
            //color: Colors.blue,
            child: Center(child: Image.asset('lib/assets/logo.png')),
          ),
          Container(
            //color: Colors.green,
            child: Center(child: Image.asset('lib/assets/logo.png')),
          ),
        ],
      );
  }
}

