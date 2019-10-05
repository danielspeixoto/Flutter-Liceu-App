import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class RoundedImage extends StatelessWidget {
  final String pictureURL;
  final String picturePath;
  final double size;

  RoundedImage({this.pictureURL, this.picturePath, this.size});

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
                  : new Image(
                              image: new AssetImage(picturePath),
                            )),
        ),
      );
}
