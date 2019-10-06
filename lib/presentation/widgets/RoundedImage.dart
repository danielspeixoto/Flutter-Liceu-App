import 'package:flutter/material.dart';
import "dart:math";
import 'package:cached_network_image/cached_network_image.dart';

final List<String> animals = [
  "assets/hedgehog.png",
  "assets/tiger.png",
  'assets/fox.png',
  'assets/cat.png',
  'assets/pig.png',
  'assets/dog.png',
  'assets/koala.png'
];

final randomAnimal = animals[new Random().nextInt(animals.length)];

class RoundedImage extends StatelessWidget {
  final String pictureURL;
  final double size;

  RoundedImage({this.pictureURL, this.size});

  @override
  Widget build(BuildContext context) => Container(
        width: this.size,
        height: this.size,
        child: new ClipOval(
          //borderRadius: BorderRadius.circular(8.0),
          child: new CachedNetworkImage(
            imageUrl: pictureURL,
            height: size / 48,
            width: size / 48,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => new Image(image: AssetImage(randomAnimal), 
          ),
        ),),
        decoration: new ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.black12,
              width: size / 48,
            ),
          ),
        ),
      );
}
