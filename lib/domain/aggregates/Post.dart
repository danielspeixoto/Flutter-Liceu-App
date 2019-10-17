class Post {
  final String id;
  final String userId;
  PostType type;
  final String text;
  final String imageURL;
  final String statusCode;
  int likes;


//  final DateTime submissionDate;

  Post(this.id, this.userId, String type, this.text, this.imageURL, this.statusCode, this.likes) {
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
