import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatelessWidget {
  final String imageURL;

  ImageZoom({
    @required this.imageURL
  });

  Widget build(BuildContext context) {
  return Container(
    child: PhotoView(
      minScale: PhotoViewComputedScale.contained,
      backgroundDecoration: BoxDecoration(color: Colors.white),
      imageProvider: NetworkImage(this.imageURL),
    )
  );
}
}
