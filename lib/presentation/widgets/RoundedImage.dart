import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import "dart:math";

final List<String> animals = [
  "assets/hedgehog.png",
  "assets/tiger.png",
  'assets/fox.png',
  'assets/cat.png',
  'assets/pig.png',
  'assets/dog.png',
  'assets/koala.png'
];

final random = new Random();

class RoundedImage extends StatelessWidget {
  final String pictureURL;
  final double size;

  RoundedImage({this.pictureURL, this.size});

  @override
  Widget build(BuildContext context) => Container(
        width: this.size,
        height: this.size,
        decoration: new ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.black12,
              width: size / 48,
            ),
          ),
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: pictureURL != null
                  ? new NetworkImageWithRetry(pictureURL)
                  : new AssetImage(animals[random.nextInt(animals.length)])),
        ),
      );
}
