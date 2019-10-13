import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ItemActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';

import '../../constants.dart';

//Navigates
class NavigateUserEditProfileAction {}

//Fetches
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

class FetchUserChallengesErrorAction {
  final String error;

  FetchUserChallengesErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class FetchUserPostsAction {
  FetchUserPostsAction();
}

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
  final String phone;
  final String desiredCourse;

  SetUserEditFieldAction({this.bio, this.instagram, this.phone, this.desiredCourse});
}

class SetUserReportFieldAction {
  final String text;

  SetUserReportFieldAction(this.text);
}

class SetUserFcmTokenAction {
  final String fcmtoken;

  SetUserFcmTokenAction(this.fcmtoken);
}
//Submits

class SubmitUserProfileChangesAction extends ItemAction {
  final String bio;
  final String instagram;
  final String desiredCourse;
  final String phone;

  SubmitUserProfileChangesAction({this.bio, this.instagram, this.desiredCourse, this.phone});

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'bio': bio,
      'instagram': instagram,
      'desiredCourse': desiredCourse,
      'phone': phone
    };
  }
}

class SubmitUserProfileChangesSuccessAction {
  final String bio;
  final String instagram;
  final String desiredCourse;
  final String phone;

  SubmitUserProfileChangesSuccessAction(this.bio, this.instagram, this.desiredCourse, this.phone);
}

class SubmitUserFcmTokenAction extends ItemAction {
  final String fcmtoken;

  SubmitUserFcmTokenAction(this.fcmtoken);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'fcmtoken': fcmtoken,
    };
  }
}

class InstagramClickedAction {
  final String instagram;

  InstagramClickedAction(this.instagram);
}

class UserProfileShareAction {}
