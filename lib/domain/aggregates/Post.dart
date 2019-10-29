import 'package:app/domain/aggregates/Comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post {
  final String id;
  final String userId;
  PostType type;
  final String text;
  final String imageURL;
  final String statusCode;
  int likes;
  final List<String> images;
  final List<Comment> comments;
  IconData savedIcon;

//  final DateTime submissionDate;

  Post(this.id, this.userId, String type, this.text, this.imageURL,
      this.statusCode, this.likes, this.images, this.comments, this.savedIcon) {
    switch (type) {
      case "text":
        this.type = PostType.TEXT;
        break;
      case "image":
        this.type = PostType.IMAGE;
        break;
    }
  }
}

enum PostType { TEXT, IMAGE }
