import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';

//Navigate
class NavigateCreatePostAction {}

//Fetches
class FetchPostsAction {}

class FetchPostsSuccessAction {
  final List<PostData> post;

  FetchPostsSuccessAction(this.post);
}

class FetchPostsErrorAction {}

//Setters

//Submits
class SubmitPostAction {
  final PostType postType;
  final String text;

  SubmitPostAction(this.postType, this.text);
}

class SubmitPostSuccessAction {}

class SubmitPostErrorTextSizeMismatchAction {}

//Deletes
class DeletePostAction {
  final String postId;

  DeletePostAction(this.postId);
}

class PostShareAction {
  final String postId;
  final String type;

  PostShareAction(this.postId, this.type);
}
