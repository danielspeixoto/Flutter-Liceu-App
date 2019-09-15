import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';

import '../../constants.dart';

class FetchMyInfoAction {
  FetchMyInfoAction();
}

class FetchMyPostsAction {
  FetchMyPostsAction();
}

class SetUserAction {
  final User user;

  SetUserAction(this.user);
}

class FetchingUserAction {}

class FetchingUserErrorAction {
  final String error;

  FetchingUserErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class SetUserPostsAction {
  final List<Post> posts;

  SetUserPostsAction(this.posts);
}

class FetchingMyPostsAction {}

class FetchingMyPostsErrorAction {
  final String error;

  FetchingMyPostsErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class SetUserEditFieldAction {
  final String bio;
  final String instagram;

  SetUserEditFieldAction({this.bio, this.instagram});
}

class SubmitUserProfileChangesAction {
  final String bio;
  final String instagram;

  SubmitUserProfileChangesAction({this.bio, this.instagram});
}

class MyProfileInfoWasChangedAction {
  final String bio;
  final String instagram;

  MyProfileInfoWasChangedAction(this.bio, this.instagram);
}
