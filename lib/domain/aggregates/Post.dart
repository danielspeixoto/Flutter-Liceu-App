class Post {
  final String id;
  final String userId;
  PostType type;
  final String text;
  final String imageURL;

//  final DateTime submissionDate;

  Post(this.id, this.userId, String type, this.text, this.imageURL) {
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
