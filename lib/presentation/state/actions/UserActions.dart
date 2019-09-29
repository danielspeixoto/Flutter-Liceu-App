import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';

import '../../constants.dart';

//Navigates

//Fetches
class FetchUserAction {}

class FetchUserErrorAction {
  final String error;

  FetchUserErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class FetchUserInfoAction {
  FetchUserInfoAction();
}

class FetchUserChallengesAction {
  FetchUserChallengesAction();
}

class FetchUserChallengesLoadingAction {}

class FetchUserChallengesErrorAction {
  final String error;

  FetchUserChallengesErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class FetchUserPostsAction {
  FetchUserPostsAction();
}

class FetchUserPostsLoadingAction {}

class FetchUserPostsErrorAction {
  final String error;

  FetchUserPostsErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

//Setters
class SetUserAction {
  final User user;

  SetUserAction(this.user);
}

class SetUserPostsAction {
  final List<Post> posts;

  SetUserPostsAction(this.posts);
}

class SetUserChallengesAction {
  final List<ChallengeHistoryData> challenges;

  SetUserChallengesAction(this.challenges);
}

class SetUserEditFieldAction {
  final String bio;
  final String instagram;

  SetUserEditFieldAction({this.bio, this.instagram});
}
//Submits

class SubmitUserProfileChangesAction {
  final String bio;
  final String instagram;

  SubmitUserProfileChangesAction({this.bio, this.instagram});
}

class SubmitUserProfileChangesSuccessAction {
  final String bio;
  final String instagram;

  SubmitUserProfileChangesSuccessAction(this.bio, this.instagram);
}
