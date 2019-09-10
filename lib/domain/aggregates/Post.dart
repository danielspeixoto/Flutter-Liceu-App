class Post {
  final String id;
  final String userId;
  final String type;
  final String text;
//  final DateTime submissionDate;

  Post(this.id, this.userId, this.type, this.text);
}

enum PostType {
  TEXT
}
