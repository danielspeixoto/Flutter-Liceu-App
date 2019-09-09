import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {

  final String pictureURL;
  final double size;

  RoundedImage({this.pictureURL, this.size});

  @override
  Widget build(BuildContext context) =>
      Container(
        width: this.size,
        height: this.size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(this.pictureURL)),
        ),
        margin: const EdgeInsets.all(16.0),
      );
}