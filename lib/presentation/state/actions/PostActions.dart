import 'dart:io';

import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/state/actions/ItemActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';

//Navigate
class NavigateCreatePostAction {}

class NavigatePostAction {
  final PostData post;

  NavigatePostAction(this.post);
}

class NavigatePostImageZoomAction {
  final List<String> imageURL;

  NavigatePostImageZoomAction(this.imageURL);
}

//Fetches
class FetchPostsAction {}

class FetchPostsSuccessAction {
  final List<PostData> post;

  FetchPostsSuccessAction(this.post);
}

class FetchPostsErrorAction {}

class FetchPostAction {
  final String postId;

  FetchPostAction(this.postId);
}

class FetchPostFromNotificationAction {
  final String postId;

  FetchPostFromNotificationAction(this.postId);
}

class SearchPostAction {
  final String query;

  SearchPostAction(this.query);
}

class SearchPostSuccessAction {
  final List<PostData> post;

  SearchPostSuccessAction(this.post);
}

//Setters
class SetImageForSubmission {
  final File image;

  SetImageForSubmission(this.image);
}

class SetCompletePostAction {
  final PostData post;

  SetCompletePostAction(this.post);
}

class SetPostImageAction {
  final List<String> imageURL;

  SetPostImageAction(this.imageURL);
}

class SetPostReportTextFieldAction {
  final String text;

  SetPostReportTextFieldAction(this.text);
}

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

class SubmitPostUpdateRatingAction {
  final String postId;

  SubmitPostUpdateRatingAction(this.postId);
}

class SubmitPostSuccessAction {}

class SubmitPostErrorTextSizeMismatchAction {}

class SubmitPostErrorAction {}

class SubmitPostCommentAction {
  final String postId;
  final String comment;

  SubmitPostCommentAction(this.postId, this.comment);
}

class SubmitPostCommentSuccessAction {
  String postId;

  SubmitPostCommentSuccessAction(this.postId);
}

class SubmitPostCommentErrorAction {}

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
