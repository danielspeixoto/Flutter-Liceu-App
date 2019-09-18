import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class UserState {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Data<List<ChallengeData>> challenges;

  UserState(this.user, this.posts, this.challenges);

  factory UserState.initial() => UserState(
        Data(),
        Data(),
    Data()
      );

  UserState copyWith({
    Data<User> user,
    Data<List<Post>> posts,
    Data<List<ChallengeData>> challenges,
  }) {
    final state = UserState(
      user ?? this.user,
      posts ?? this.posts,
      challenges ?? this.challenges,
    );
    return state;
  }
}

final Reducer<UserState> userReducer = combineReducers<UserState>([
//  Personal Data
  TypedReducer<UserState, SetUserAction>(setProfileData),
  TypedReducer<UserState, FetchingUserAction>(fetchingUser),
  TypedReducer<UserState, FetchingUserErrorAction>(fetchingUserError),
//  Posts
  TypedReducer<UserState, SetUserPostsAction>(setUserPosts),
  TypedReducer<UserState, FetchingMyPostsAction>(fetchingMyPosts),
  TypedReducer<UserState, FetchingMyPostsErrorAction>(fetchingMyPostsError),
  TypedReducer<UserState, DeletePostAction>(deletePost),
//  Challenges
  TypedReducer<UserState, SetUserChallengesAction>(setUserChallenges),
  TypedReducer<UserState, FetchingMyChallengesAction>(fetchingMyChallenges),
  TypedReducer<UserState, FetchingMyChallengesErrorAction>(fetchingMyChallengesError),
]);

UserState setProfileData(UserState state, SetUserAction action) {
  return state.copyWith(user: Data(content: action.user, isLoading: false));
}

UserState fetchingUser(UserState state, FetchingUserAction action) {
  final s = state.copyWith(user: Data(isLoading: true));
  return s;
}

UserState fetchingUserError(UserState state, FetchingUserErrorAction action) {
  final s =
      state.copyWith(user: Data(errorMessage: action.error, isLoading: false));
  return s;
}

UserState setUserPosts(UserState state, SetUserPostsAction action) {
  return state.copyWith(posts: Data(content: action.posts, isLoading: false));
}

UserState fetchingMyPosts(UserState state, FetchingMyPostsAction action) {
  return state.copyWith(
    posts: state.posts.copyWith(isLoading: true),
  );
}

UserState fetchingMyPostsError(
    UserState state, FetchingMyPostsErrorAction action) {
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
  return state.copyWith(challenges: Data(content: action.challenges, isLoading: false));
}

UserState fetchingMyChallenges(UserState state, FetchingMyChallengesAction action) {
  return state.copyWith(
    challenges: state.challenges.copyWith(isLoading: true),
  );
}

UserState fetchingMyChallengesError(
    UserState state, FetchingMyChallengesErrorAction action) {
  final s =
  state.copyWith(challenges: Data(errorMessage: action.error, isLoading: false));
  return s;
}