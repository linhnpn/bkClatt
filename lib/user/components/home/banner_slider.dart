import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/cleaning-1.png"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/cleaning-2.jpg"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/cleaning-3.jpg"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/cleaning-4.jpg"),
        ),
      ],
    );
  }
}
