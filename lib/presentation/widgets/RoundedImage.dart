import "dart:math";

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final List<String> animals = [
  "assets/hedgehog.png",
  "assets/tiger.png",
  'assets/fox.png',
  'assets/cat.png',
  'assets/pig.png',
  'assets/dog.png',
  'assets/koala.png'
];
  final random = new Random().nextInt(animals.length);


class RoundedImage extends StatelessWidget {
  final String pictureURL;
  final double size;
  final randomAnimal = animals[random];
  RoundedImage({this.pictureURL, this.size});

  @override
  Widget build(BuildContext context) => Container(
        width: this.size,
        height: this.size,
        child: new ClipOval(
          child: new CachedNetworkImage(
            imageUrl: pictureURL,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => new Image(
              image: AssetImage(randomAnimal),
            ),
          ),
        ),
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
