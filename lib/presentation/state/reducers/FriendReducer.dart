import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class FriendState {
  final Data<User> user;
  final Data<List<Post>> posts;

  FriendState(this.user, this.posts);

  factory FriendState.initial() => FriendState(
        Data(),
        Data(),
      );

  FriendState copyWith({
    Data<User> user,
    Data<List<Post>> posts,
  }) {
    final state = FriendState(
      user ?? this.user,
      posts ?? this.posts,
    );
    return state;
  }
}

final Reducer<FriendState> friendReducer = combineReducers<FriendState>([
//  Personal Data
  TypedReducer<FriendState, SetFriendAction>(setProfileData),
  TypedReducer<FriendState, FetchFriendAction>(fetchingFriend),
  TypedReducer<FriendState, FetchFriendErrorAction>(fetchingFriendError),
//  Posts
  TypedReducer<FriendState, SetFriendPostsAction>(setFriendPosts),
  TypedReducer<FriendState, FetchFriendPostsAction>(fetchingMyPosts),
  TypedReducer<FriendState, FetchFriendPostsErrorAction>(fetchingMyPostsError),
  TypedReducer<FriendState, DeletePostAction>(deletePost),
]);

FriendState setProfileData(FriendState state, SetFriendAction action) {
  return state.copyWith(user: Data(content: action.user, isLoading: false));
}

FriendState fetchingFriend(FriendState state, FetchFriendAction action) {
  return state.copyWith(user: Data(isLoading: true));
}

FriendState fetchingFriendError(
    FriendState state, FetchFriendErrorAction action) {
  return state.copyWith(
      user: Data(errorMessage: action.error, isLoading: false));
}

FriendState setFriendPosts(FriendState state, SetFriendPostsAction action) {
  return state.copyWith(posts: Data(content: action.posts, isLoading: false));
}

FriendState fetchingMyPosts(FriendState state, FetchFriendPostsAction action) {
  return state.copyWith(
    posts: state.posts.copyWith(isLoading: true),
  );
}

FriendState fetchingMyPostsError(
    FriendState state, FetchFriendPostsErrorAction action) {
  return state.copyWith(
      posts: Data(errorMessage: action.error, isLoading: false));
}

FriendState deletePost(FriendState state, DeletePostAction action) {
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
