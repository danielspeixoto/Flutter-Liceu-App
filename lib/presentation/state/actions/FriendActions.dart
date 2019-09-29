import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';

import '../../constants.dart';

//Navigates
class NavigateViewFriendAction {
  final User user;

  NavigateViewFriendAction(this.user);
}

//Fetches
class FetchFriendAction {
  final String id;

  FetchFriendAction(this.id);
}

class FetchFriendErrorAction {
  final String error;

  FetchFriendErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class FetchFriendPostsAction {
  final String id;

  FetchFriendPostsAction(this.id);
}

class FetchFriendPostsErrorAction {
  final String error;

  FetchFriendPostsErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

//Setters
class SetFriendAction {
  final User user;

  SetFriendAction(this.user);
}

class SetFriendPostsAction {
  final List<Post> posts;

  SetFriendPostsAction(this.posts);
}

