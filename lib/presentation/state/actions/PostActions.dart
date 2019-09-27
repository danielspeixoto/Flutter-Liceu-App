import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';

class DeletePostAction {
  final String postId;

  DeletePostAction(this.postId);
}

class CreatePostAction {
  final PostType postType;
  final String text;

  CreatePostAction(this.postType, this.text);
}

class PostCreationAction {}

class PostCreatedAction {}

class ExplorePostsAction {}

class ExplorePostsRetrievedAction {
  final List<PostData> post;

  ExplorePostsRetrievedAction(this.post);
}

class ExplorePostsErrorAction {}