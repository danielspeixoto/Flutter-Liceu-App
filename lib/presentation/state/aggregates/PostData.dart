import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';

class PostData {
  final String id;
  final User user;
  final PostType type;
  final String text;
  final String imageURL;
  final String statusCode;

  PostData(this.id, this.user, this.type, this.text, this.imageURL,
      this.statusCode);
}
