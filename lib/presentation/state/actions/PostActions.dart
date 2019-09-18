import 'package:app/domain/aggregates/Post.dart';

class DeletePostAction {
  final String postId;

  DeletePostAction(this.postId);
}

class CreatePostAction {
  final PostType postType;
  final String text;

  CreatePostAction(this.postType, this.text);
}

class PostCreatedAction {

}