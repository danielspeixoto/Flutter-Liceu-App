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
class SubmitTextPostAction extends ItemAction {
  final String text;

  SubmitTextPostAction(this.text);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{'text': text};
  }
}

class SubmitImagePostAction extends ItemAction {
  final String text;
  final String imageData;

  SubmitImagePostAction(this.text, this.imageData);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{'text': text};
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
  final PostType type;

  PostShareAction(this.postId, this.type);
}
