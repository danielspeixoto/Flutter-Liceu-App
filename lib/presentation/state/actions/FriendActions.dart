import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ItemActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';

import '../../constants.dart';

//Navigates
class NavigateViewFriendAction {
  NavigateViewFriendAction();
}

//Fetches
class FetchFriendAction extends ItemAction {
  final String id;

  FetchFriendAction(this.id);

      @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'id': id
    };
  }
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

class SetFriendPostReportTextFieldAction {
  final String text;

  SetFriendPostReportTextFieldAction(this.text);
}

class UserClickedAction {
  final User user;

  UserClickedAction(this.user);
}
