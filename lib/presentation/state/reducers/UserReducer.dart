import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class UserState {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Data<List<ChallengeHistoryData>> challenges;
  final String fcmtoken;

  UserState(this.user, this.posts, this.challenges, this.fcmtoken);

  factory UserState.initial() => UserState(Data(), Data(), Data(), null);

  UserState copyWith({
    Data<User> user,
    Data<List<Post>> posts,
    Data<List<ChallengeHistoryData>> challenges,
    String fcmtoken
  }) {
    final state = UserState(
      user ?? this.user,
      posts ?? this.posts,
      challenges ?? this.challenges,
      fcmtoken ?? this.fcmtoken
    );
    return state;
  }
}

final Reducer<UserState> userReducer = combineReducers<UserState>([
//  Personal Data
  TypedReducer<UserState, SetUserAction>(setProfileData),
  TypedReducer<UserState, FetchUserInfoAction>(fetchUser),
  TypedReducer<UserState, FetchUserErrorAction>(fetchUserError),
//  Posts
  TypedReducer<UserState, SetUserPostsAction>(setUserPosts),
  TypedReducer<UserState, FetchUserPostsAction>(fetchUserPosts),
  TypedReducer<UserState, FetchUserPostsErrorAction>(fetchUserPostsError),
  TypedReducer<UserState, DeletePostAction>(deletePost),
//  Challenges
  TypedReducer<UserState, SetUserChallengesAction>(setUserChallenges),
  TypedReducer<UserState, FetchUserChallengesAction>(fetchUserChallenges),
  TypedReducer<UserState, FetchUserChallengesErrorAction>(
      fetchUserChallengesError),
  TypedReducer<UserState, SetUserFcmTokenAction>(setFcmToken),
]);

UserState setProfileData(UserState state, SetUserAction action) {
  return state.copyWith(user: Data(content: action.user, isLoading: false));
}

UserState fetchUser(UserState state, FetchUserInfoAction action) {
  final s = state.copyWith(user: Data(isLoading: true));
  return s;
}

UserState fetchUserError(UserState state, FetchUserErrorAction action) {
  final s =
      state.copyWith(user: Data(errorMessage: action.error, isLoading: false));
  return s;
}

UserState setUserPosts(UserState state, SetUserPostsAction action) {
  return state.copyWith(posts: Data(content: action.posts, isLoading: false));
}

UserState fetchUserPosts(UserState state, FetchUserPostsAction action) {
  return state.copyWith(
    posts: state.posts.copyWith(isLoading: true),
  );
}

UserState fetchUserPostsError(
    UserState state, FetchUserPostsErrorAction action) {
  final s =
      state.copyWith(posts: Data(errorMessage: action.error, isLoading: false));
  return s;
}

UserState deletePost(UserState state, DeletePostAction action) {
  if (state.posts.content == null) {
    return state;
  }
  final posts = state.posts.content.where((post) {
    return post.id != action.postId;
  }).toList();
  return state.copyWith(
    posts: state.posts.copyWith(
      content: posts,
    ),
  );
}

UserState setUserChallenges(UserState state, SetUserChallengesAction action) {
  return state.copyWith(
      challenges: Data(content: action.challenges, isLoading: false));
}

UserState fetchUserChallenges(
    UserState state, FetchUserChallengesAction action) {
  return state.copyWith(
    challenges: state.challenges.copyWith(isLoading: true),
  );
}

UserState fetchUserChallengesError(
    UserState state, FetchUserChallengesErrorAction action) {
  final s = state.copyWith(
      challenges: Data(errorMessage: action.error, isLoading: false));
  return s;
}

UserState setFcmToken(UserState state, SetUserFcmTokenAction action) {
  return state.copyWith(
    fcmtoken: action.fcmtoken
  );
}
