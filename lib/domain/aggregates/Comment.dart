import 'package:app/domain/aggregates/User.dart';

class Comment {
  final String id;
  final String userId;
  final String author;
  final String content;
  User user;

  Comment(this.id, this.userId, this.author, this.content, this.user);
}