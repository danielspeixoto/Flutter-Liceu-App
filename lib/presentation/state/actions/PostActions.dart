import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/ItemActions.dart';
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
class SubmitPostAction extends ItemAction {
  final PostType postType;
  final String text;

  SubmitPostAction(this.postType, this.text);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{'postType': postType, 'text': text};
  }
}

class SubmitPostSuccessAction {}

class SubmitPostErrorTextSizeMismatchAction {}

//Deletes
class DeletePostAction extends ItemAction {
  final String postId;

  DeletePostAction(this.postId);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{'postId': postId};
  }
}

class PostShareAction {
  final String postId;
  final String type;

  PostShareAction(this.postId, this.type);

}
