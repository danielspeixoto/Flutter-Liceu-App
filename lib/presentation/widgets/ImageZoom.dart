import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageZoom extends StatelessWidget {
  final List<String> imageURL;

  ImageZoom({@required this.imageURL});

  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            this.imageURL[index],
          ),
        );
      },
      itemCount: imageURL.length,
      backgroundDecoration: BoxDecoration(color: Colors.transparent),
    ));
  }
}
